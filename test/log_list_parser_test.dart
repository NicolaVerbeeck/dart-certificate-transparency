import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:certificate_transparency/src/internal/model/google_public_key.dart';
import 'package:certificate_transparency/src/internal/parser/log_list_parser.dart';
import 'package:certificate_transparency/src/internal/parser/log_list_verifier.dart';
import 'package:certificate_transparency/src/model/raw_log_list.dart';
import 'package:test/test.dart';

void main() {
  group('Log list parser tests', () {
    test('Parse valid signature', () {
      final logListBytes = base64.decode(base64.normalize(
          File('test/test_log_list.dat')
              .readAsStringSync()
              .replaceAll('\n', '')));
      final sigBytes = base64.decode(base64.normalize(
          File('test/test_log_list_sig.dat')
              .readAsStringSync()
              .replaceAll('\n', '')));
      expect(
          LogListParser(LogListVerifier(GoogleLogListPublicKey))
              .parse(RawLogList(logList: logListBytes, signature: sigBytes))
              .operators
              .isNotEmpty,
          true);
    });
    test('Parse invalid signature', () {
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
          () => LogListParser(LogListVerifier(GoogleLogListPublicKey))
              .parse(RawLogList(logList: logListBytes, signature: signature))
              .operators
              .isNotEmpty,
          throwsA(isA<Exception>()));
    });
  });
}
