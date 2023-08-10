import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:pinput/pinput.dart';

class PPinPutWidget extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String? validatorText;
  final String? warningText;
  final bool isError;
  final Function(String)? onChange;

  const PPinPutWidget({
    required this.controller,
    required this.label,
    this.validatorText,
    this.warningText,
    this.onChange,
    this.isError = false,
    super.key,
  });

//TODO Change style text theme
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: Get.theme.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        Pinput(
          onChanged: onChange,
          length: 6,
          controller: controller,
          defaultPinTheme: PinTheme(
            width: 48,
            height: 46,
            textStyle: Get.theme.textTheme.titleSmall,
            decoration: BoxDecoration(
              color: AppColors.gray100,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.gray300,
              ),
            ),
          ),
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          forceErrorState: isError,
          preFilledWidget: Text(
            '0',
            style: Get.theme.textTheme.titleSmall,
          ),
          errorPinTheme: PinTheme(
            width: 48,
            height: 46,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.red,
              ),
            ),
          ),
          submittedPinTheme: PinTheme(
            width: 48,
            height: 46,
            textStyle: Get.textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w500),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: AppColors.gray600,
              ),
            ),
          ),
        ),
        const SizedBox(height: 8),
        _validator(),
        _warning()
      ],
    );
  }

  Widget _validator() {
    return Visibility(
      visible: isError == true,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 12,
                child: PSVGIcon(
                  icon: 'icon_warning',
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                validatorText ?? '',
                style: Get.theme.inputDecorationTheme.errorStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _warning() {
    return Visibility(
      visible: isError == true,
      child: IntrinsicHeight(
        child: Row(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 12,
                child: PSVGIcon(
                  icon: 'icon_caution',
                  color: Get.theme.colorScheme.onError,
                ),
              ),
            ),
            const SizedBox(width: 4),
            RichText(
              text: TextSpan(
                  text: 'txt_you_have_only'.tr,
                  style: Get.theme.textTheme.bodySmall!.copyWith(
                    color: Get.theme.colorScheme.onError,
                  ),
                  children: <InlineSpan>[
                    const WidgetSpan(
                      child: SizedBox(width: 5),
                    ),
                    TextSpan(
                      text: warningText,
                      style: Get.theme.textTheme.bodySmall!.copyWith(
                        color: Get.theme.colorScheme.onError,
                      ),
                    ),
                    const WidgetSpan(
                      child: SizedBox(width: 5),
                    ),
                    TextSpan(
                      text: 'txt_attempts'.tr,
                      style: Get.theme.textTheme.bodySmall!.copyWith(
                        color: Get.theme.colorScheme.onError,
                      ),
                    ),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
