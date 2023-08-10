import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:parallel/module/profile_edit/edit_profile_controller.dart';
import 'package:parallel/widget/p_bottom_sheet_widget.dart';

class ChooseDateBirthdayWidget extends GetView<EditProfileController> {
  const ChooseDateBirthdayWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return PBottomSheetWidget(
      mediumTitle: 'txt_choose_your_birthday_date'.tr.capitalizeFirst!,
      textFirstButton: 'txt_choose'.tr.capitalizeFirst!,
      onPressedFirstButton: () => Get.back(),
      child: ShaderMask(
        blendMode: BlendMode.dstOut,
        shaderCallback: (Rect rect) {
          return LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Colors.white.withOpacity(0.7),
              Colors.transparent,
              Colors.white.withOpacity(1),
            ],
            stops: const [
              0.3,
              0.3,
              1,
            ],
          ).createShader(rect);
        },
        child: SizedBox(
          height: 212,
          child: CupertinoDatePicker(
            mode: CupertinoDatePickerMode.date,
            onDateTimeChanged: (DateTime value) {
              controller.clearValidationError(value);
              controller.dateBirthdayRx.value = value;
              controller.dateBirthdayController.text = DateFormat('MM/dd/yyyy')
                  .format(controller.dateBirthdayRx.value!);
            },
            initialDateTime: controller.dateBirthdayRx.value,
          ),
        ),
      ),
    );
  }
}
