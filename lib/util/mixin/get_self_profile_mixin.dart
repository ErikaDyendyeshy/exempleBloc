import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';

mixin GetSelfProfileMixin on GetxController {
  late ValueListenable<Box<ProfileModel>> userListenable;
  final ProfileRepository _profileRepository = Get.find();
  final ErrorHandler _errorHandler = Get.find();
  final Rx<ProfileModel?> selfProfile = Rx(null);
  final RxBool isProfileLoading = false.obs;

  Future<void> getUserMe() async {
    isProfileLoading.value = true;
    await _profileRepository.getUserMe().then((ProfileModel newSelfProfile) {
      selfProfile.value = newSelfProfile;
    }).catchError((error) {
      _errorHandler.handleException(error);
      isProfileLoading.value = false;
    });
    isProfileLoading.value = false;
  }
}
