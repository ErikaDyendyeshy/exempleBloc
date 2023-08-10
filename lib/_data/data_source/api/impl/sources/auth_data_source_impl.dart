import 'dart:convert';

import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/auth_data_source.dart';
import 'package:parallel/_data/model/model/auth/auth_model.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';
import 'package:parallel/_data/model/model/logout_model.dart';
import 'package:parallel/_data/model/request/auth/email_login_request.dart';
import 'package:parallel/_data/model/request/auth/email_registration_request.dart';
import 'package:parallel/_data/model/request/change_password/change_password_request.dart';
import 'package:parallel/_data/model/request/forgot_password/forgot_password_request.dart';
import 'package:parallel/_data/model/request/update_token_refresh_request.dart';
import 'package:parallel/util/http_extension.dart';

class AuthDataSourceImpl extends AuthDataSource {
  final GetStorage _storage = GetStorage();
  static const String _keyAuthToken = 'AuthToken';
  static const String _keyRefreshToken = 'RefreshToken';

  AuthDataSourceImpl({
    required super.getConnect,
    required super.apiDataSource,
  });

  @override
  Future<RemainingAttemptsModel> registerByEmail({
    required String name,
    required String email,
    required String password,
    required String passwordRepeat,
  }) {
    return getConnect
        .postRequest(
      url: 'auth/send-registration-code',
      request: EmailRegistrationRequest(
        name: name,
        email: email,
        password: password,
        passwordRepeat: passwordRepeat,
      ),
    )
        .then((Response response) {
      return RemainingAttemptsModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
  }

  @override
  Future<bool> confirmCode({
    required String name,
    required String email,
    required String password,
    required String passwordRepeat,
    required String code,
  }) {
    return getConnect
        .postRequest(
      url: 'auth/register',
      request: EmailRegistrationRequest(
        name: name,
        email: email,
        password: password,
        passwordRepeat: passwordRepeat,
        code: code,
      ),
    )
        .then((Response response) {
      return AuthModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    }).then((authModel) {
      saveAuthToken(authModel.accessToken);
      saveRefreshToken(authModel.refreshToken);
      return authModel.accessToken.isNotEmpty;
    });
  }

  @override
  Future<bool> loginByEmail({
    required String email,
    required String password,
  }) {
    return getConnect
        .postRequest(
          url: 'auth/login',
          request: EmailLoginRequest(
            email: email,
            password: password,
          ),
        )
        .then(
          (Response response) => AuthModel.fromJson(
            jsonDecode(
              response.bodyString!,
            ),
          ),
        )
        .then((authModel) {
      saveAuthToken(authModel.accessToken);
      saveRefreshToken(authModel.refreshToken);
      return authModel.accessToken.isNotEmpty;
    });
  }

  @override
  Future<String?> getAuthToken() async {
    return _storage.read(_keyAuthToken);
  }

  @override
  Future<String?> getRefreshToken() async {
    return _storage.read(_keyRefreshToken);
  }

  @override
  Future<void> saveAuthToken(String authToken) {
    return _storage.write(
      _keyAuthToken,
      authToken,
    );
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) {
    return _storage.write(
      _keyRefreshToken,
      refreshToken,
    );
  }

  @override
  Future<String> updateAccessToken({
    required String refreshToken,
  }) async {
    AuthModel authModel = await getConnect
        .postRequest(
          url: 'auth/token-refresh',
          request: UpdateTokenRefreshRequest(
            refreshToken: refreshToken,
          ),
        )
        .then(
          (Response response) => AuthModel.fromJson(
            jsonDecode(
              response.bodyString!,
            ),
          ),
        );

    saveAuthToken(authModel.accessToken);
    return authModel.accessToken;
  }

  @override
  Future<void> clearTokens() async {
    await _storage.erase();
    return;
  }

  @override
  Future<RemainingAttemptsModel> forgotPassword({
    required String email,
  }) async {
    return getConnect
        .postRequest(
      url: 'auth/send-password-code',
      request: ForgotPasswordRequest(
        email: email,
      ),
    )
        .then((Response response) {
      return RemainingAttemptsModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
  }

  @override
  Future<void> changePassword({
    required String email,
    required String code,
    required String newPassword,
    required String repeatNewPassword,
    required String oldPassword,
  }) async {
    return getConnect
        .postRequest(
          url: 'auth/change-password-with-code',
          request: ChangePasswordRequest(
            email: email,
            code: code,
            newPassword: newPassword,
            repeatNewPassword: repeatNewPassword,
            oldPassword: oldPassword,
          ),
        )
        .then(
          (response) => response.isOk,
        );
  }

  @override
  Future<void> logout() async {
    String refresh = await _storage.read(_keyRefreshToken);

    await getConnect
        .postRequest(
          url: 'auth/logout',
          request: LogoutModel(
            refresh: refresh,
          ),
        )
        .then(
          (value) => value.status.isOk,
        );
  }

  @override
  Future<void> confirmChangePassword({
    required String email,
    required String code,
    required String newPassword,
    required String repeatNewPassword,
  }) {
    return getConnect
        .postRequest(
          url: 'auth/forget-password-with-code',
          request: ChangePasswordRequest(
            email: email,
            code: code,
            newPassword: newPassword,
            repeatNewPassword: repeatNewPassword,
          ),
        )
        .then(
          (response) => response.isOk,
        );
  }
}
