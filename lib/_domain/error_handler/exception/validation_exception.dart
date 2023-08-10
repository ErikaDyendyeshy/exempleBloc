import 'package:parallel/_domain/error_handler/exception/base_exeption.dart';
import 'package:parallel/_domain/error_handler/exception/exeption_type.dart';

class ValidationException extends BaseException {
  final Map<String, dynamic> messages;

  const ValidationException(this.messages) : super(ExceptionType.validation);

  String? getMessageForField(String fieldName) {
    if (messages.containsKey(fieldName)) {
      dynamic message = messages[fieldName];
      if (message is List<dynamic> && message.isNotEmpty) {
        return message.first.toString();
      } else if (message != null) {
        return message.toString();
      }
    }
    return null;
  }
}
