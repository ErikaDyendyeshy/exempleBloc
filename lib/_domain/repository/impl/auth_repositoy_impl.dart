import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/error_handler/exception/base_exeption.dart';
import 'package:parallel/_domain/error_handler/exception/unauth_exception.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiDataSource _apiDataSource;
  final ErrorHandler _errorHandler;

  AuthRepositoryImpl(
    this._apiDataSource,
    this._errorHandler,
  );

  @override
  Future<RemainingAttemptsModel> registerByEmail({
    required String name,
    required String email,
    required String password,
    required String passwordRepeat,
  }) async {
    return _apiDataSource.authDataSource
        .registerByEmail(
      name: name,
      email: email,
      password: password,
      passwordRepeat: passwordRepeat,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<bool> confirmCode({
    required String name,
    required String email,
    required String password,
    required String passwordRepeat,
    required String code,
  }) async {
    return _apiDataSource.authDataSource
        .confirmCode(
      name: name,
      email: email,
      password: password,
      passwordRepeat: passwordRepeat,
      code: code,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<void> loginByEmail({
    required String email,
    required String password,
  }) async {
    return _apiDataSource.authDataSource.loginByEmail(email: email, password: password);
  }

  @override
  Future<void> forgotPassword({
    required String email,
  }) async {
    return _apiDataSource.authDataSource.forgotPassword(email: email).catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<void> changePassword({
    required String email,
    required String code,
    required String newPassword,
    required String repeatNewPassword,
    required String oldPassword,
  }) async {
    return _apiDataSource.authDataSource
        .changePassword(
      email: email,
      code: code,
      newPassword: newPassword,
      repeatNewPassword: repeatNewPassword,
      oldPassword: oldPassword,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<void> logout() async {
    await _apiDataSource.authDataSource.logout();
    _errorHandler.handleException(const UnAuthException("logout"));
  }

  @override
  Future<void> confirmChangePassword({
    required String email,
    required String code,
    required String newPassword,
    required String repeatNewPassword,
  }) async {
    return _apiDataSource.authDataSource
        .confirmChangePassword(
      email: email,
      code: code,
      newPassword: newPassword,
      repeatNewPassword: repeatNewPassword,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }
}
