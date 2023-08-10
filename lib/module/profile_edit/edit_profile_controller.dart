import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:parallel/_data/model/model/file_model.dart';
import 'package:parallel/_data/model/request/update_profile/update_custom_info_request.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/module/profile_edit/widget/choose_date_birthday_widget.dart';
import 'package:parallel/module/profile_edit/widget/custom_field_form_widget.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';
import 'package:parallel/widget/p_bottom_sheet_widget.dart';

class EditProfileController extends GetxController with SubscribeSelfProfileMixin {
  final ProfileRepository _profileRepository = Get.find();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController dateBirthdayController = TextEditingController();
  final TextEditingController countryController = TextEditingController();
  final TextEditingController aboutMeController = TextEditingController();
  final TextEditingController myInterestController = TextEditingController();
  final TextEditingController textEditingController = TextEditingController();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController infoController = TextEditingController();

  final FocusNode tagFocusNode = FocusNode();

  final RxList<UpdateCustomInfoRequest> customFields = <UpdateCustomInfoRequest>[].obs;
  final RxList<Map<String, String>> allCountries = <Map<String, String>>[].obs;
  final RxList<Map<String, String>> displayedCountries = <Map<String, String>>[].obs;
  late final RxList<String> tags = <String>[].obs;

  final RxString titleRx = ''.obs;
  final RxString infoRx = ''.obs;
  final RxString nameRx = ''.obs;
  final RxString inputNameErrorMsg = ''.obs;

  final Rx<DateTime?> dateBirthdayRx = Rx(DateTime.now());

  final Rx<File?> avatarFileRx = Rx(null);
  final Rx<FileModel?> avatarUri = Rx(null);
  final RxBool isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadCountries();
  }

  @override
  void onReady() {
    fillData();
    super.onReady();
  }

  void fillData() {
    nameController.text = selfProfile.value!.user.name;
    if (selfProfile.value!.user.birthDate.isNotEmpty) {
      DateTime birthDate = DateFormat('yyyy-MM-dd').parse(selfProfile.value!.user.birthDate);
      dateBirthdayController.text = DateFormat('MM/dd/yyyy').format(birthDate);
    }
    if (selfProfile.value!.user.country?.isNotEmpty ?? false) {
      countryController.text = selfProfile.value!.user.country!;
    }
    if (selfProfile.value!.user.aboutMe.isNotEmpty) {
      aboutMeController.text = selfProfile.value!.user.aboutMe;
    }
    if (selfProfile.value!.tags.isNotEmpty) {
      tags.addAll(selfProfile.value!.tags.map((tag) => tag.tag));
    }
    if (selfProfile.value!.customInfo.isNotEmpty) {
      customFields.value = selfProfile.value!.customInfo.map((customInfo) {
        return UpdateCustomInfoRequest(
          title: customInfo.title,
          info: customInfo.info,
        );
      }).toList();
    }
  }

  void checkName(String text) {
    clearValidationError(text);
    nameRx.value = text;
  }

  void loadCountries() async {
    String jsonString = await rootBundle.loadString('assets/countries.json');
    List<dynamic> jsonList = json.decode(jsonString);
    displayedCountries.value = jsonList.cast<Map<String, String>>();
  }

  void filterCountries(String query) {
    if (query.isEmpty) {
      displayedCountries.value = allCountries;
    } else {
      displayedCountries.value = allCountries
          .where((country) =>
              country['name']!.toLowerCase().contains(query.toLowerCase()) ||
              country['name']!.toLowerCase().startsWith(query.toLowerCase()))
          .toList();
    }
  }

  void getBack() {
    Get.bottomSheet(
      PBottomSheetWidget(
        title: 'txt_save_changes'.tr.capitalizeFirst!,
        description: 'txt_your_unsaved_changes_will_be_lost'.tr.capitalizeFirst!,
        textFirstButton: 'txt_save'.tr,
        textSecondButton: 'txt_dont_save'.tr,
        onPressedSecondButton: () => Get.close(2),
        onPressedFirstButton: () {
          saveProfile();
          Get.back();
        },
      ),
    );
  }

  Future saveProfile() async {
    if (avatarFileRx.value != null) {
      avatarUri.value = await _profileRepository.sendFile(
        filePath: avatarFileRx.value!.path,
      );
    }
    _profileRepository
        .editProfile(
      id: selfProfile.value!.user.id,
      name: nameController.text,
      birthdayDate: DateFormat('yyyy-MM-dd').format(dateBirthdayRx.value!),
      country: countryController.text,
      aboutMe: aboutMeController.text,
      tags: tags,
      avatarUri:
          avatarUri.value != null ? avatarUri.value!.file : selfProfile.value!.user.avatarUrl,
      customFields: customFields,
    )
        .then((value) {
      Get.back();
      Get.showSuccessMessage(
        'txt_you_successfully_saved_changes'.tr.capitalizeFirst!,
      );
    });
  }

  void clearValidationError(value) {
    inputNameErrorMsg.value = '';
  }

  void pickAvatar() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedFile =
        await picker.pickImage(source: ImageSource.gallery, imageQuality: 100);

    if (pickedFile != null) {
      avatarFileRx.value = File(pickedFile.path);
    }
  }

  void openChangeDate() {
    Get.bottomSheet(
      isScrollControlled: false,
      ignoreSafeArea: true,
      const ChooseDateBirthdayWidget(),
    );
  }

  void openChangeCountry() {
    // Get.bottomSheet(
    //   PBottomSheetWidget(
    //     mediumTitle: 'txt_choose_your_country'.tr.capitalizeFirst!,
    //     textFirstButton: 'txt_choose'.tr.capitalizeFirst!,
    //     onPressedFirstButton: () => Get.back(),
    //     child: const CountryWidget(),
    //   ),
    // );
    Get.showErrorMessage('Sorry!', 'This section is under development');
  }

  void confirmProfileDeletion() {
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      PBottomSheetWidget(
        title: '${'txt_delete_profile'.tr.capitalizeFirst!}?',
        description: 'txt_if_your_delete_this_page'.tr.capitalizeFirst!,
        textFirstButton: 'txt_delete'.tr.capitalizeFirst!,
        textSecondButton: 'txt_cancel'.tr.capitalizeFirst!,
        onPressedSecondButton: () => Get.back(),
        onPressedFirstButton: () => deleteProfile(),
      ),
    );
  }

  void openChangeEmailScreen() {
    Get.toNamed(RoutePaths.changeEmail);
  }

  void openChangePasswordScreen() {
    Get.showErrorMessage('Sorry!', 'This section is under development');
    // Get.toNamed(RoutePaths.changePassword);
  }

  void deleteProfile() {
    _profileRepository.deleteProfile();
    Get.offAllNamed(RoutePaths.firstPage);
  }

  //-----------------------------------------CREATE AND DELETE TAG

  void addTag() {
    final String tag = textEditingController.text.trim();
    if (tag.isNotEmpty && !tags.contains(tag)) {
      tags.add(tag);
      textEditingController.clear();
    }
  }

  void removeTag(String tag) {
    tags.remove(tag);
  }

  void submitTag() {
    addTag();
    tagFocusNode.requestFocus();
  }

  //-----------------------------------------ADD NEW CUSTOM FIELD

  void addCustomField(String title, String info) {
    final customField = UpdateCustomInfoRequest(title: title, info: info);
    customFields.add(customField);
    Get.back();
  }

  void deleteCustomField(UpdateCustomInfoRequest customInfo) {
    customFields.remove(customInfo);
  }

  void checkTitle(String text) {
    titleRx.value = text;
  }

  void checkDescription(String text) {
    infoRx.value = text;
  }

  void addNewCustomField() {
    Get.bottomSheet(
      isScrollControlled: true,
      ignoreSafeArea: false,
      PBottomSheetWidget(
        mediumTitle: 'txt_category_new_name'.tr.capitalizeFirst!,
        child: const CustomFieldFormWidget(),
      ),
    );
  }

  bool get isFormValid {
    return titleRx.isEmpty || infoRx.isEmpty;
  }
}
