import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/auth/remaining_attempts_model.dart';
import 'package:parallel/_domain/error_handler/exception/validation_exception.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/util/mixin/get_self_profile_mixin.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';

class ChangeEmailController extends GetxController
    with GetSelfProfileMixin, SubscribeSelfProfileMixin {
  final ProfileRepository _profileRepository = Get.find();
  final TextEditingController newEmailController = TextEditingController();
  final TextEditingController codeConfirmController = TextEditingController();

  final RxString inputCodeErrorMsg = ''.obs;
  final RxString inputEmailErrorMsg = ''.obs;
  final RxString remainingAttemptsRx = ''.obs;
  final RxString codeConfirmRx = ''.obs;

  final FocusNode emailFocusNode = FocusNode();

  final RxBool isConfirmationCodeFull = false.obs;

  final RxString newEmailRx = ''.obs;

  final RxInt _step = 0.obs;

  ChangeEmailController() {
    emailFocusNode.addListener(_checkEmailOnFocusChange);
}

  void _checkEmailOnFocusChange() {
    if (!emailFocusNode.hasFocus) {
      _validateEmail();
    }
  }

  void _validateEmail() {
    String text = newEmailController.text;
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
      newEmailRx.value = text;
    }
  }

  void sendEmailChangeCode() {
    Get.showSuccessMessage('txt_confirmation_code_was_sent_to_your_email'.tr.capitalizeFirst!);
    _profileRepository.sendEmailChangeCode().then((RemainingAttemptsModel remainingAttempts) {
      remainingAttemptsRx.value = remainingAttempts.remainingAttempts.toString();
      setStepAction();
    });
  }

  void changeEmailWithCode() {
    _profileRepository
        .changeEmailWithCode(email: newEmailController.text, code: codeConfirmController.text)
        .then((RemainingAttemptsModel remainingAttempts) {
      remainingAttemptsRx.value = remainingAttempts.remainingAttempts.toString();
      Get.back();
      Get.showSuccessMessage('txt_you_have_successfully_changed_your_email'.tr.capitalizeFirst!);
    }).catchError((exception) {
      if (exception is ValidationException) {
        if (exception.getMessageForField('email') != null) {
          inputEmailErrorMsg.value = exception.getMessageForField('email')!;
        }
        if (exception.getMessageForField('code') != null) {
          inputCodeErrorMsg.value = exception.getMessageForField('code')!;
        }
      }
    });
  }

  void resendCode() {
    _profileRepository.sendEmailChangeCode().then((RemainingAttemptsModel remainingAttempts) {
      remainingAttemptsRx.value = remainingAttempts.remainingAttempts.toString();
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

  void getBack() {
    step != 0 ? step-- : Get.back();
  }

  void setStepAction() {
    step++;
  }

  bool get isEmailValid {
    String pattern = r'^.+@[a-zA-Z]+\.{1}[a-zA-Z]+(\.{0,1}[a-zA-Z]+)$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(newEmailRx.value);
  }

  int get step => _step.value;

  set step(int value) {
    if (value == _step.value) {
      return;
    }
    _step.value = value;
  }
}
