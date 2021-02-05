class ErrorResponseException implements Exception {
  final int _statusCode;
  final String _message;
  final Map<String, List<String>> _errors;

  ErrorResponseException(this._statusCode, this._message, this._errors);

  int get statusCode => _statusCode;

  String get message => _message;

  Map<String, List<String>> get errors => _errors;

  @override
  String toString() {
    return 'ErrorResponseException{_statusCode: $_statusCode, _message: $_message, _errors: $_errors}';
  }
}
