import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';
import 'package:parallel/_domain/error_handler/exception/validation_exception.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/extensions/snackbar.dart';

class SignUpController extends GetxController {
  final AuthRepository _authRepository = Get.find();
  final ProfileRepository _profileRepository = Get.find();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController passwordRepeatController = TextEditingController();
  final TextEditingController codeConfirmController = TextEditingController();

  final RxString nameRx = ''.obs;
  final RxString emailRx = ''.obs;
  final RxString passwordRx = ''.obs;
  final RxString passwordRepeatRx = ''.obs;
  final RxString codeConfirmRx = ''.obs;
  final RxString inputNameErrorMsg = ''.obs;
  final RxString inputEmailErrorMsg = ''.obs;
  final RxString inputPasswordErrorMsg = ''.obs;
  final RxString inputCodeErrorMsg = ''.obs;
  final RxString errorMsgRx = ''.obs;

  final FocusNode emailFocusNode = FocusNode();

  final RxInt _step = 0.obs;
  final RxInt remainingAttemptsRx = 0.obs;

  final RxBool passwordObscured = true.obs;
  final RxBool passwordRepeatObscured = true.obs;
  final RxBool isConfirmationCodeFull = false.obs;
  final RxBool isLoading = false.obs;

  SignUpController() {
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

  void registerByEmail() {
    isLoading.value = true;
    _authRepository
        .registerByEmail(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordRepeat: passwordRepeatController.text,
    )
        .then((RemainingAttemptsModel remainingAttempts) {
      setStepAction();

      remainingAttemptsRx.value = remainingAttempts.remainingAttempts;
    }).then((value) async {
      await _profileRepository.getUserMe();
      isLoading.value = false;
    }).catchError((exception) {
      isLoading.value = false;
      if (exception is ValidationException) {
        if (exception.getMessageForField('name') != null) {
          inputNameErrorMsg.value = exception.getMessageForField('name')!;
        }
        if (exception.getMessageForField('email') != null) {
          inputEmailErrorMsg.value = exception.getMessageForField('email')!;
        }
        if (exception.getMessageForField('password') != null) {
          inputPasswordErrorMsg.value = exception.getMessageForField('password')!;
        }
        if (exception.getMessageForField('non_field_errors') != null) {
          errorMsgRx.value = exception.getMessageForField('non_field_errors')!;
        }
      }
    });
  }

  void confirmCode() {
    isLoading.value = true;
    _authRepository
        .confirmCode(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordRepeat: passwordRepeatController.text,
      code: codeConfirmController.text,
    )
        .then((value) {
      isLoading.value = false;
      Get.offNamed(RoutePaths.signUpCompleted);
    }).catchError((exception) {
      isLoading.value = false;
      if (exception is ValidationException) {
        if (exception.getMessageForField('code') != null) {
          inputCodeErrorMsg.value = exception.getMessageForField('code')!;
        }
      }
    });
  }

  void resendCode() {
    Get.showSuccessMessage('txt_confirmation_code_was_sent_to_your_email'.tr.capitalizeFirst!);
    _authRepository.registerByEmail(
      name: nameController.text,
      email: emailController.text,
      password: passwordController.text,
      passwordRepeat: passwordRepeatController.text,
    );
  }

  void getBack() {
    if (step == 0) {
      Get.back();
    } else if (step == 1) {
      step--;
    }
  }

  void checkName(String text) {
    clearValidationError(text);
    nameRx.value = text;
  }

  void checkPassword(String text) {
    clearValidationError(text);
    passwordRx.value = text;
  }

  void checkPasswordRepeat(String text) {
    clearValidationError(text);
    passwordRepeatRx.value = text;
  }

  void checkCode(String text) {
    clearValidationError(text);
    codeConfirmRx.value = text;
    checkLengthConfirmCode();
  }

  void clearValidationError(value) {
    inputNameErrorMsg.value = '';
    inputPasswordErrorMsg.value = '';
    inputCodeErrorMsg.value = '';
  }

  bool checkLengthConfirmCode() {
    isConfirmationCodeFull.value = codeConfirmRx.value.length >= 6;
    return isConfirmationCodeFull.value;
  }

  void setStepAction() {
    step++;
  }

  void openLoginScreen() {
    Get.toNamed(RoutePaths.login);
  }

  int get step => _step.value;

  set step(int value) {
    if (value == _step.value) {
      return;
    }
    _step.value = value;
  }

  bool get isFormValid {
    return nameRx.isNotEmpty &&
        emailRx.isNotEmpty &&
        passwordRx.value.length >= 8 &&
        passwordRepeatRx.value.length >= 8;
  }
}
