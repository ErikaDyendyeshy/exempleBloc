import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/auth_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/local_storage_data_source.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/error_handler/exception/base_exeption.dart';
import 'package:parallel/_domain/error_handler/exception/exeption_type.dart';
import 'package:parallel/route/app_routes.dart';

class ErrorHandlerImpl implements ErrorHandler {
  final AuthDataSource _authDataSource;
  final LocalStorageDataSource _localStorageDataSource;

  ErrorHandlerImpl(
    this._authDataSource,
    this._localStorageDataSource,
  );

  @override
  void handleException(
    dynamic exception,
  ) {
    if (exception is BaseException) {
      switch (exception.type) {
        case ExceptionType.unauth:
          {
            _handleUnAuth();
            break;
          }
        case ExceptionType.validation:
          {
            throw exception;
          }
      }
    } else {
      // unsupported
    }
  }

  void _handleUnAuth() async {
    await _authDataSource.clearTokens();
    await _localStorageDataSource.clearLocalDB();
    await FirebaseMessaging.instance.deleteToken();

    Get.offAllNamed(RoutePaths.login);
  }
}
