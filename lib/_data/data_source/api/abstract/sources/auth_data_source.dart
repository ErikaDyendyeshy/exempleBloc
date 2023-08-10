import 'package:parallel/_data/data_source/api/abstract/data_source.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';

abstract class AuthDataSource extends DataSource {
  AuthDataSource({
    required super.getConnect,
    required super.apiDataSource,
  });

  Future<RemainingAttemptsModel> registerByEmail({
    required String name,
    required String email,
    required String password,
    required String passwordRepeat,
  });

  Future<bool> confirmCode({
    required String name,
    required String email,
    required String password,
    required String passwordRepeat,
    required String code,
  });

  Future<void> loginByEmail({
    required String email,
    required String password,
  });

  Future<String?> getAuthToken();

  Future<void> saveAuthToken(
    String authToken,
  );

  Future<String?> getRefreshToken();

  Future<void> saveRefreshToken(
    String refreshToken,
  );

  Future<String> updateAccessToken({
    required String refreshToken,
  });

  Future<void> clearTokens();

  Future<void> forgotPassword({
    required String email,
  });

  Future<void> changePassword({
    required String email,
    required String code,
    required String newPassword,
    required String repeatNewPassword,
    required String oldPassword,
  });

  Future<void> logout();

  Future<void> confirmChangePassword({
    required String email,
    required String code,
    required String newPassword,
    required String repeatNewPassword,
  });
}
