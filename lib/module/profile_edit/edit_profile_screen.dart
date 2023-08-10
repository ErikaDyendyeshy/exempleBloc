import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/request/update_profile/update_custom_info_request.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/profile_edit/edit_profile_controller.dart';
import 'package:parallel/module/profile_edit/widget/tag_text_field_widget.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_image_widget.dart';

class EditProfileScreen extends GetView<EditProfileController> {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text('txt_edit_profile'.tr.capitalizeFirst!),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(16.0),
          child: PSVGIcon(
            icon: 'icon_arrow_left',
            onTap: controller.getBack,
            height: 16,
            width: 16,
          ),
        ),
        actions: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                height: 28,
                child: PButtonWidget(
                  onPressed: () => controller.saveProfile(),
                  autoSize: true,
                  borderRadius: 14,
                  text: 'txt_save'.tr.capitalizeFirst!,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
        ],
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: horizontalPaddingScreen,
          vertical: 16,
        ),
        child: Column(
          children: [
            _avatar(),
            _personalInfo(),
            _aboutYou(),
            _personalizedInfo(),
          ],
        ),
      ),
    );
  }

  Widget _avatar() {
    return Padding(
      padding: const EdgeInsets.only(
        top: 16.0,
        bottom: 8,
      ),
      child: Obx(
        () => GestureDetector(
          onTap: () => controller.pickAvatar(),
          child: Center(
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: controller.selfProfile.value!.user.avatarUrl.isNotEmpty
                    ? Stack(
                        children: [
                          controller.avatarFileRx.value != null
                              ? PImageWidget(
                                  url: controller.avatarFileRx.value!.path,
                                  width: 80,
                                  height: 80,
                                )
                              : PImageWidget(
                                  url: controller.selfProfile.value!.user.avatarUrl,
                                ),
                          Container(
                            color: Get.theme.disabledColor.withOpacity(.3),
                            child: BackdropFilter(
                              filter: ImageFilter.blur(
                                sigmaX: 2.0,
                                sigmaY: 2.0,
                              ),
                              child: const Center(
                                child: PSVGIcon(
                                  icon: 'icon_photo',
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                    : Stack(
                        children: [
                          controller.avatarFileRx.value == null
                              ? Center(
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    color: Get.theme.disabledColor,
                                  ),
                                )
                              : PImageWidget(
                                  url: controller.avatarFileRx.value!.path,
                                  width: 80,
                                  height: 80,
                                ),
                          Center(
                            child: PSVGIcon(
                              icon: 'icon_photo',
                              color: Get.theme.colorScheme.background,
                            ),
                          ),
                        ],
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _personalInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'txt_1_personal_info'.tr,
            style: Get.theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 14),
          PInputTextFieldWidget(
            labelText: 'txt_name'.tr.toUpperCase(),
            controller: controller.nameController,
            textInputAction: TextInputAction.next,
            onChanged: (value) => controller.checkName(value),
            validatorText: controller.inputNameErrorMsg.value.isNotEmpty
                ? controller.inputNameErrorMsg.value
                : null,
          ),
          const SizedBox(height: 12),
          PInputTextFieldWidget(
            labelText: 'txt_birthday_date'.tr.toUpperCase(),
            hintText: '(MM/DD/YYYY)',
            trailingIcon: 'icon_calendar',
            readOnly: true,
            controller: controller.dateBirthdayController,
            colorIcon: Get.theme.colorScheme.onSurface,
            onTap: () => controller.openChangeDate(),
          ),
          const SizedBox(height: 12),
          PInputTextFieldWidget(
            labelText: 'txt_country'.tr.toUpperCase(),
            hintText: 'txt_choose_your_country'.tr.capitalizeFirst!,
            trailingIcon: 'icon_carret_down',
            readOnly: true,
            colorIcon: Get.theme.colorScheme.onSurface,
            controller: controller.countryController,
            onTap: () => controller.openChangeCountry(),
          ),
        ],
      ),
    );
  }

  Widget _aboutYou() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'txt_2_about_you'.tr,
            style: Get.theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'txt_fill_in_information_about_yourself'.tr,
            style: Get.theme.textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          PInputTextFieldWidget(
            labelText: 'txt_about_me'.tr.toUpperCase(),
            hintText: 'txt_write_something_about_yourself'.tr,
            controller: controller.aboutMeController,
            textInputAction: TextInputAction.next,
            maxLength: 400,
            maxLines: 6,
          ),
          const SizedBox(height: 12),
          const TagTextFieldWidget(),
        ],
      ),
    );
  }

  Widget _personalizedInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            'txt_3_personalized_info'.tr,
            style: Get.theme.textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'txt_customise_your_profile_by_filling_in_detailed_information'.tr,
            style: Get.theme.textTheme.titleLarge,
          ),
          Obx(
            () => controller.customFields.isNotEmpty
                ? ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.customFields.length,
                    itemBuilder: (context, index) {
                      final customField = controller.customFields[index];
                      return itemCustomInfo(customField);
                    },
                  )
                : const SizedBox.shrink(),
          ),
          const SizedBox(height: 16),
          PButtonWidget(
            leading: const PSVGIcon(icon: 'icon_plus'),
            textButton: true,
            text: 'txt_add_new_category'.tr,
            onPressed: () => controller.addNewCustomField(),
          ),
          const SizedBox(height: 37),
          PButtonWidget(
            text: 'txt_change_email'.tr,
            colorTrascparent: true,
            onPressed: () => controller.openChangeEmailScreen(),
          ),
          const SizedBox(height: 13),
          PButtonWidget(
            text: 'txt_change_password'.tr,
            colorTrascparent: true,
            onPressed: () => controller.openChangePasswordScreen(),
          ),
          const SizedBox(height: 13),
          PButtonWidget(
            text: 'txt_delete_profile'.tr,
            colorTrascparent: true,
            colorBorder: Get.theme.colorScheme.error,
            textStyle: Get.theme.textTheme.displayMedium!.copyWith(
              color: Get.theme.colorScheme.error,
            ),
            onPressed: () => controller.confirmProfileDeletion(),
          ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget itemCustomInfo(UpdateCustomInfoRequest customField) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${customField.title}'.toUpperCase(),
                style: Get.theme.textTheme.labelLarge,
              ),
              InkWell(
                onTap: () => controller.deleteCustomField(customField),
                child: Text(
                  'txt_remove'.tr.toUpperCase(),
                  style: Get.theme.textTheme.labelLarge!.copyWith(
                    color: Get.theme.colorScheme.error,
                  ),
                ),
              )
            ],
          ),
          const SizedBox(height: 5),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 16,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.onBackground,
              borderRadius: BorderRadius.circular(
                8,
              ),
            ),
            child: Text(customField.info.toString()),
          ),
        ],
      ),
    );
  }
}
