enum ErrorType {
  CONNECTION_ERROR,
  TIMEOUT,
  INTERNAL_SERVER_ERROR,
  BAD_REQUEST,
  NOT_FOUND,
  UNPROCESSABLE_ENTITY
}

class ErrorTypeTranslator {
  static ErrorType translate(int statusCode) {
    if (statusCode >= 500) return ErrorType.INTERNAL_SERVER_ERROR;

    if (statusCode == 422) return ErrorType.UNPROCESSABLE_ENTITY;

    if (statusCode == 400) return ErrorType.BAD_REQUEST;

    if (statusCode == 422) return ErrorType.UNPROCESSABLE_ENTITY;

    if (statusCode == 400) return ErrorType.NOT_FOUND;

    return ErrorType.CONNECTION_ERROR;
  }
}
