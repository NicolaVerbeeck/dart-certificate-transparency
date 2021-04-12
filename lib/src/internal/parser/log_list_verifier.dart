import 'dart:convert';
import 'dart:typed_data';

import 'package:asn1lib/asn1lib.dart';
import 'package:crypto_keys/crypto_keys.dart';

class LogListVerifier {
  final RsaPublicKey _publicKey;

  LogListVerifier(String publicKey) : _publicKey = _parsePublicKey(publicKey);

  bool verify(final Uint8List message, final Uint8List signature) {
    return _publicKey
        .createVerifier(algorithms.signing.rsa.sha256)
        .verify(message, Signature(signature));
  }

  static RsaPublicKey _parsePublicKey(String pemString) {
    final publicKeyDER = _decodePEM(pemString);
    final asn1Parser = ASN1Parser(publicKeyDER);
    // ignore: avoid_as
    final topLevelSeq = asn1Parser.nextObject() as ASN1Sequence;
    final publicKeyBitString = topLevelSeq.elements[1];

    final publicKeyAsn = ASN1Parser(publicKeyBitString.contentBytes()!);
    // ignore: avoid_as
    final publicKeySeq = publicKeyAsn.nextObject() as ASN1Sequence;
    // ignore: avoid_as
    final modulus = publicKeySeq.elements[0] as ASN1Integer;
    // ignore: avoid_as
    final exponent = publicKeySeq.elements[1] as ASN1Integer;

    return RsaPublicKey(
      modulus: modulus.valueAsBigInteger!,
      exponent: exponent.valueAsBigInteger!,
    );
  }

  static Uint8List _decodePEM(String pem) {
    final startsWith = [
      '-----BEGIN PUBLIC KEY-----',
    ];
    final endsWith = [
      '-----END PUBLIC KEY-----',
    ];
    var processedPem = pem;

    for (final s in startsWith) {
      if (processedPem.startsWith(s)) {
        processedPem = processedPem.substring(s.length);
      }
    }
    for (final s in endsWith) {
      if (processedPem.endsWith(s)) {
        processedPem =
            processedPem.substring(0, processedPem.length - s.length);
      }
    }

    processedPem = processedPem..replaceAll('\n', '')..replaceAll('\r', '');
    return base64.decode(pem);
  }
}
