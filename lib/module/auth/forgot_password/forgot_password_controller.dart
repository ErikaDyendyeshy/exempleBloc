import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/_domain/error_handler/exception/validation_exception.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/extensions/snackbar.dart';

class ForgotPasswordController extends GetxController {
  final AuthRepository _authRepository = Get.find();

  TextEditingController emailController = TextEditingController();
  TextEditingController confirmCodeController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController repeatNewPasswordController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  final RxString emailRx = ''.obs;
  final RxString confirmCodeRx = ''.obs;
  final RxString newPasswordRx = ''.obs;
  final RxString repeatNewPasswordRx = ''.obs;
  final RxString remainingAttemptsRx = ''.obs;

  final RxString inputEmailErrorMsg = ''.obs;
  final RxString inputCodeErrorMsg = ''.obs;
  final RxString inputPasswordErrorMsg = ''.obs;

  final RxBool passwordObscured = true.obs;
  final RxBool passwordRepeatObscured = true.obs;
  final RxBool isConfirmationCodeFull = false.obs;
  final RxBool isLoading = false.obs;

  final RxInt _step = 0.obs;

  ForgotPasswordController() {
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

  void requestResetPasswordCodeByEmail() {
    if (step == 0) {
      isLoading.value = true;
      _authRepository.forgotPassword(email: emailController.text).then((value) {
        isLoading.value = false;
        setStepAction();
        Get.showSuccessMessage('txt_confirmation_code_was_sent_to_your_email'.tr.capitalizeFirst!);
      }).catchError((exception) {
        isLoading.value = false;
        if (exception is ValidationException) {
          if (exception.getMessageForField('email') != null) {
            inputEmailErrorMsg.value = exception.getMessageForField('email')!;
          }
        }
      });
    } else if (step == 1) {
      setStepAction();
    } else if (step == 2) {
      confirmChangePassword();
    }
  }

  void resendCode() {
    _authRepository.forgotPassword(email: emailController.text).then((value) {
      Get.showSuccessMessage('txt_confirmation_code_was_sent_to_your_email'.tr.capitalizeFirst!);
    });
  }

  void confirmChangePassword() async {
    try {
      isLoading.value = true;
      await _authRepository.confirmChangePassword(
        email: emailController.text,
        code: confirmCodeController.text,
        newPassword: newPasswordController.text,
        repeatNewPassword: repeatNewPasswordController.text,
      );

      isLoading.value = false;
      Get.showSuccessMessage('txt_you_have_successfully_reset'.tr.capitalizeFirst!);
      Get.offAndToNamed(RoutePaths.login);
    } catch (exception) {
      isLoading.value = false;

      if (exception is ValidationException) {
        if (exception.getMessageForField('email') != null) {
          inputEmailErrorMsg.value = exception.getMessageForField('email')!;
        }
        if (exception.getMessageForField('code') != null) {
          inputCodeErrorMsg.value = exception.getMessageForField('code')!;
        }
        if (exception.getMessageForField('password') != null) {
          inputPasswordErrorMsg.value = exception.getMessageForField('password')!;
        }
      } else {
        Get.snackbar('Error', 'Something went wrong');
      }


    }
  }


  void openSingUp() {
    Get.toNamed(RoutePaths.signUp);
  }

  void getBack() {
    step != 0 ? step-- : Get.back();
  }

  void checkName(String text) {
    clearValidationError(text);
    emailRx.value = text;
  }

  void checkCode(String text) {
    clearValidationError(text);
    confirmCodeRx.value = text;
    checkLengthConfirmCode();
  }

  void checkNewPassword(String text) {
    clearValidationError(text);
    newPasswordRx.value = text;
  }

  void checkNewPasswordRepeat(String text) {
    clearValidationError(text);
    repeatNewPasswordRx.value = text;
  }

  bool checkLengthConfirmCode() {
    isConfirmationCodeFull.value = confirmCodeRx.value.length >= 6;
    return isConfirmationCodeFull.value;
  }

  void clearValidationError(value) {
    inputEmailErrorMsg.value = '';
    inputCodeErrorMsg.value = '';
    inputPasswordErrorMsg.value = '';
  }

  void setStepAction() {
    step++;
  }

  bool get isFormValid {
    switch (step) {
      case 0:
        return emailRx.isNotEmpty;
      case 1:
        return confirmCodeRx.value.length >= 6;
      case 2:
        return newPasswordRx.value.length >= 8 && newPasswordRx.value.length >= 8;
      default:
        false;
    }
    return false;
  }

  int get step => _step.value;

  set step(int value) {
    if (value == _step.value) {
      return;
    }
    _step.value = value;
  }

}
