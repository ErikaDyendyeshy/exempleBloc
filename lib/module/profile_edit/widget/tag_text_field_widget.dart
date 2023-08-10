import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/profile_edit/edit_profile_controller.dart';

class TagTextFieldWidget extends GetView<EditProfileController> {
  const TagTextFieldWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'txt_my_interest'.tr.toUpperCase(),
          style: Get.theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 5),
        Container(
          padding: const EdgeInsets.only(
            top: 8,
            right: 8,
            left: 8,
          ),
          width: Get.width,
          decoration: BoxDecoration(
            color: Get.theme.colorScheme.onBackground,
            borderRadius: BorderRadius.circular(
              8,
            ),
          ),
          child: Obx(
            () => Wrap(spacing: 8, runSpacing: 8, children: [
              ...List<Widget>.generate(
                controller.tags.length,
                (index) => InputChip(
                  backgroundColor: Get.theme.colorScheme.surface,
                  labelStyle: Get.theme.textTheme.headlineMedium!.copyWith(
                    fontSize: 14,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  label: Text(controller.tags[index]),
                  onDeleted: () => controller.removeTag(controller.tags[index]),
                ),
              ),
              ConstrainedBox(
                constraints: BoxConstraints(
                  minWidth: 30,
                  maxWidth: Get.width,
                  maxHeight: 40,
                ),
                child: IntrinsicWidth(
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'txt_write_your_interest'.tr.capitalizeFirst!,
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                    ),
                    controller: controller.textEditingController,
                    onSubmitted: (_) => controller.submitTag(),
                    focusNode: controller.tagFocusNode,
                  ),
                ),
              ),
            ]),
          ),
        ),
      ],
    );
  }
}
