import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:certificate_transparency/src/internal/model/google_public_key.dart';
import 'package:certificate_transparency/src/internal/parser/log_list_verifier.dart';
import 'package:test/test.dart';

void main() {
  group('Log list verifier tests', () {
    test('Verify signature', () {
      final logListBytes = base64.decode(base64.normalize(
          File('test/test_log_list.dat')
              .readAsStringSync()
              .replaceAll('\n', '')));
      final sigBytes = base64.decode(base64.normalize(
          File('test/test_log_list_sig.dat')
              .readAsStringSync()
              .replaceAll('\n', '')));
      expect(
          LogListVerifier(GoogleLogListPublicKey)
              .verify(logListBytes, sigBytes),
          true);
    });
    test('Verify signature incorrect', () {
      final logListBytes = base64.decode(base64.normalize(
          File('test/test_log_list.dat')
              .readAsStringSync()
              .replaceAll('\n', '')));
      final sigBytes = base64.decode(base64.normalize(
          File('test/test_log_list_sig.dat')
              .readAsStringSync()
              .replaceAll('\n', '')));

      final signature = Uint8List.fromList(sigBytes);
      signature[2] = 0xFF;
      expect(
          LogListVerifier(GoogleLogListPublicKey)
              .verify(logListBytes, signature),
          false);
    });
  });
}
