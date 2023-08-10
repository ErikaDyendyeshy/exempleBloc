import 'package:parallel/_domain/error_handler/exception/base_exeption.dart';
import 'package:parallel/_domain/error_handler/exception/exeption_type.dart';

class UnAuthException extends BaseException {
  final String message;

  const UnAuthException(
    this.message,
  ) : super(
          ExceptionType.unauth,
        );
}
