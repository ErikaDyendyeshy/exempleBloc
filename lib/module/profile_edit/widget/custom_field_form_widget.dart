import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/profile_edit/edit_profile_controller.dart';
import 'package:parallel/widget/__.dart';

class CustomFieldFormWidget extends GetView<EditProfileController> {
  const CustomFieldFormWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          PInputTextFieldWidget(
            onChanged: (value) => controller.checkTitle(value),
            controller: controller.titleController,
            labelText: 'txt_category_name'.tr.toUpperCase(),
            textInputAction: TextInputAction.next,
          ),
          const SizedBox(height: 16),
          PInputTextFieldWidget(
            onChanged: (value) => controller.checkDescription(value),
            controller: controller.infoController,
            labelText: 'txt_description'.tr.toUpperCase(),
            maxLines: 6,
            textInputAction: TextInputAction.go,
            maxLength: 400,
          ),
          const SizedBox(height: 16),
          Obx(
            () => PButtonWidget(
              disabled: controller.isFormValid,
              text: 'txt_add_category'.tr,
              onPressed: () {
                final title = controller.titleController.text;
                final info = controller.infoController.text;
                controller.addCustomField(title, info);
                controller.titleController.clear();
                controller.infoController.clear();
              },
              leading: PSVGIcon(
                icon: 'icon_plus',
                color: controller.isFormValid
                    ? Get.theme.colorScheme.onSurface
                    : Get.theme.colorScheme.background,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
