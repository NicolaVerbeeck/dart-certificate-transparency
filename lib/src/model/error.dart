class NetworkException implements Exception {
  final String message;

  NetworkException(this.message);
}

class SignatureException implements Exception {
  final String message;

  SignatureException(this.message);
}
