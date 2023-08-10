import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';

mixin SubscribeSelfProfileMixin on GetxController {
  late ValueListenable<Box<ProfileModel>> userListenable;
  final ProfileRepository _profileRepository = Get.find();
  final Rx<ProfileModel?> selfProfile = Rx(null);

  @override
  void onInit() {
    super.onInit();
    _subscribeOnSelfProfile();
  }

  @override
  void onClose() {
    _unSubscribeOnSelfProfile();
    super.onClose();
  }

  void _unSubscribeOnSelfProfile() {
    userListenable.removeListener(_profileListener);
  }

  void _subscribeOnSelfProfile() {
    userListenable = _profileRepository.userMe() as ValueListenable<Box<ProfileModel>>;
    _profileListener();
    userListenable.addListener(_profileListener);
  }

  void _profileListener() {
    Iterable<ProfileModel> values = userListenable.value.values;
    if (values.isNotEmpty) {
      final ProfileModel user = values.first;
      selfProfile.value = user;
    }
  }
}
