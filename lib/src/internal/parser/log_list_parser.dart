import 'dart:convert';

import 'package:certificate_transparency/src/internal/model/log_list.dart';
import 'package:certificate_transparency/src/model/error.dart';
import 'package:certificate_transparency/src/model/raw_log_list.dart';

import 'log_list_verifier.dart';

class LogListParser {
  final LogListVerifier logListVerifier;

  LogListParser(this.logListVerifier);

  LogListV2 parse(RawLogList logList) {
    if (!logListVerifier.verify(logList.logList, logList.signature)) {
      throw SignatureException('Failed to verify signature: incorrect');
    }
    // ignore: avoid_as
    return LogListV2.fromJson(
        json.decode(utf8.decode(logList.logList)) as Map<String, dynamic>);
  }
}
