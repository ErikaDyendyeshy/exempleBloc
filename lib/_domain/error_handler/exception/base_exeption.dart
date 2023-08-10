import 'package:parallel/_domain/error_handler/exception/exeption_type.dart';

abstract class BaseException implements Exception {
  final ExceptionType type;

  const BaseException(
    this.type,
  );
}
