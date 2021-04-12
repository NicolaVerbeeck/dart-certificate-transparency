import 'dart:typed_data';

abstract class LogListService {
  Future<Uint8List> getLogList();

  Future<Uint8List> getLogListSignature();

  Future<Uint8List> getLogListZip();
}
