import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/_domain/error_handler/exception/validation_exception.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/route/app_routes.dart';

class LoginController extends GetxController {
  final AuthRepository _authRepository = Get.find();
  final ProfileRepository _profileRepository = Get.find();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  final RxString emailRx = ''.obs;
  final RxString passwordRx = ''.obs;

  final RxString inputEmailErrorMsg = ''.obs;
  final RxString inputPasswordErrorMsg = ''.obs;
  final RxString errorMsgRx = ''.obs;

  final RxBool passwordObscured = true.obs;
  final RxBool isLoading = false.obs;

  LoginController() {
    emailFocusNode.addListener(_checkEmailOnFocusChange);
  }

  void _checkEmailOnFocusChange() {
    if (!emailFocusNode.hasFocus) {
      _validateEmail();
    }
  }

  @override
  void onClose() {
    emailFocusNode.dispose();
    super.onClose();
  }

  void loginByEmail() {
    isLoading.value = true;
    _authRepository
        .loginByEmail(
      email: emailController.text,
      password: passwordController.text,
    )
        .then((value) async {
      await _profileRepository.getUserMe();
      isLoading.value = false;
      Get.offAllNamed(RoutePaths.main);
    }).catchError((exception) {
      isLoading.value = false;
      if (exception is ValidationException) {
        if (exception.getMessageForField('email') != null) {
          inputEmailErrorMsg.value = exception.getMessageForField('email')!;
        }
        if (exception.getMessageForField('password') != null) {
          inputPasswordErrorMsg.value = exception.getMessageForField('password')!;
        }
        if (exception.getMessageForField('user') != null) {
          errorMsgRx.value = exception.getMessageForField('user')!;
        }
      }
    });
  }

  void _validateEmail() {
    String text = emailController.text;
    String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regExp = RegExp(pattern);
    if (!regExp.hasMatch(text)) {
      inputEmailErrorMsg.value = 'txt_enter_valid_email'.tr.capitalizeFirst!;
    } else {
      inputEmailErrorMsg.value = '';
    }
  }

  void validateAndClearEmailError(String text) {
    String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regExp = RegExp(pattern);
    if (regExp.hasMatch(text)) {
      inputEmailErrorMsg.value = '';
      emailRx.value = text;
    }
  }

  void checkPassword(String text) {
    passwordRx.value = text;
  }

  void openForgotPassword() {
    Get.toNamed(RoutePaths.forgotPassword);
  }

  void openSingUp() {
    Get.toNamed(RoutePaths.signUp);
  }

  bool get isFormValid {
    return emailRx.isNotEmpty && passwordRx.value.length >= 8;
  }
}
