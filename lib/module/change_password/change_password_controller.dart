import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/_domain/error_handler/exception/validation_exception.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';

class ChangePasswordController extends GetxController with SubscribeSelfProfileMixin {
  final AuthRepository _authRepository = Get.find();
  final TextEditingController oldPasswordController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController repeatNewPasswordController = TextEditingController();
  final TextEditingController codeConfirmController = TextEditingController();

  final RxString oldPasswordRx = ''.obs;
  final RxString newPasswordRx = ''.obs;
  final RxString repeatNewPasswordRx = ''.obs;
  final RxString inputOldPasswordErrorMsg = ''.obs;
  final RxString inputNewPasswordErrorMsg = ''.obs;
  final RxString inputRepeatNewPasswordErrorMsg = ''.obs;
  final RxString inputCodeErrorMsg = ''.obs;
  final RxString remainingAttemptsRx = ''.obs;
  final RxString codeConfirmRx = ''.obs;

  final RxBool isConfirmationCodeFull = false.obs;
  final RxBool oldPasswordObscured = true.obs;
  final RxBool newPasswordObscured = true.obs;
  final RxBool repeatNewPasswordObscured = true.obs;

  final RxInt _step = 0.obs;

  void sendPasswordChangeCode() {
    if (newPasswordRx.value == repeatNewPasswordRx.value) {
      _authRepository.forgotPassword(email: selfProfile.value!.user.email!).then((value) {
        setStepAction();
        Get.showSuccessMessage('txt_confirmation_code_was_sent_to_your_email'.tr.capitalizeFirst!);
      });
    } else {
      inputRepeatNewPasswordErrorMsg.value =
          'txt_the_second_password_is_not_the_same_as_the_first'.tr;
    }
  }

  void changePasswordWithCode() {
    _authRepository
        .changePassword(
      oldPassword: oldPasswordController.text,
      email: selfProfile.value!.user.email!,
      code: codeConfirmController.text,
      newPassword: newPasswordController.text,
      repeatNewPassword: repeatNewPasswordController.text,
    )
        .then((value) {
      Get.showSuccessMessage('txt_you_have_successfully_reset'.tr.capitalizeFirst!);
      Get.back();
    }).catchError((exception) {
      if (exception is ValidationException) {
        if (exception.getMessageForField('code') != null) {
          inputCodeErrorMsg.value = exception.getMessageForField('code')!;
        }
        if (exception.getMessageForField('password') != null) {
          inputNewPasswordErrorMsg.value = exception.getMessageForField('password')!;
        }
      }
    });
  }

  void resendCode() {
    _authRepository.forgotPassword(email: selfProfile.value!.user.email!).then((value) {
      Get.showSuccessMessage('txt_confirmation_code_was_sent_to_your_email'.tr.capitalizeFirst!);
    });
  }

  void checkCode(String text) {
    codeConfirmRx.value = text;
    checkLengthConfirmCode();
    inputCodeErrorMsg.value = '';
  }

  bool checkLengthConfirmCode() {
    isConfirmationCodeFull.value = codeConfirmRx.value.length >= 6;
    return isConfirmationCodeFull.value;
  }

  void checkOldPassword(String text) {
    oldPasswordRx.value = text;
    clearValidation();
  }

  void checkNewPassword(String text) {
    newPasswordRx.value = text;
    clearValidation();
  }

  void checkRepeatNewPassword(String text) {
    repeatNewPasswordRx.value = text;
    clearValidation();
  }

  void clearValidation() {
    inputOldPasswordErrorMsg.value = '';
    inputNewPasswordErrorMsg.value = '';
    inputRepeatNewPasswordErrorMsg.value = '';
  }

  void getBack() {
    step != 0 ? step-- : Get.back();
  }

  void setStepAction() {
    step++;
  }

  bool get isFormValid {
    return oldPasswordRx.isNotEmpty &&
        newPasswordRx.value.length >= 8 &&
        repeatNewPasswordRx.value.length >= 8;
  }

  int get step => _step.value;

  set step(int value) {
    if (value == _step.value) {
      return;
    }
    _step.value = value;
  }
}
