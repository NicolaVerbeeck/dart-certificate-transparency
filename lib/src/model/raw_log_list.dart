import 'dart:typed_data';

import 'package:meta/meta.dart';

@immutable
class RawLogList {
  final Uint8List logList;
  final Uint8List signature;

  const RawLogList({
    required this.logList,
    required this.signature,
  });
}
