import 'dart:typed_data';

import 'package:certificate_transparency/certificate_transparency.dart';
import 'package:certificate_transparency/src/internal/service/log_list_service.dart';
import 'package:http/http.dart' as http;
import 'package:meta/meta.dart';

@immutable
class HttpLogListService implements LogListService {
  final String _baseUrl;

  HttpLogListService({required String baseUrl}) : _baseUrl = baseUrl {
    if (_baseUrl.endsWith('/')) {
      throw ArgumentError("Base url must not end in '/'");
    }
  }

  @override
  Future<Uint8List> getLogList() async {
    final uri = Uri.parse('$_baseUrl/log_list.json');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw NetworkException(
          'Failed to get log list. Http status: ${response.statusCode}');
    }
    return response.bodyBytes;
  }

  @override
  Future<Uint8List> getLogListSignature() async {
    final uri = Uri.parse('$_baseUrl/log_list.sig');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw NetworkException(
          'Failed to get log list signature. Http status: ${response.statusCode}');
    }
    return response.bodyBytes;
  }

  @override
  Future<Uint8List> getLogListZip() async {
    final uri = Uri.parse('$_baseUrl/log_list.zip');
    final response = await http.get(uri);
    if (response.statusCode != 200) {
      throw NetworkException(
          'Failed to get log list. Http status: ${response.statusCode}');
    }
    return response.bodyBytes;
  }
}
