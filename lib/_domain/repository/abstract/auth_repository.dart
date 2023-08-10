import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';

abstract class AuthRepository {
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
