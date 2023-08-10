import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/__.dart';

class PConfirmationCodeWidget extends StatelessWidget {
  final TextEditingController controller;
  final String email;
  final String validatorText;
  final String warningText;
  final String? errorMessage;
  final bool isError;
  final bool disabledButton;
  final double height;
  final Function(String) onChange;
  final Function() onTapResendCode;
  final Function() onPressed;

  const PConfirmationCodeWidget(
      {super.key,
      required this.height,
      required this.controller,
      required this.email,
      required this.validatorText,
      required this.warningText,
      this.errorMessage,
      required this.isError,
      required this.disabledButton,
      required this.onChange,
      required this.onTapResendCode,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          PTitleBlockWidget(
            title: 'txt_6_digit_code',
            description: '${'txt_please_enter_code'.tr} $email',
          ),
          const SizedBox(height: 12),
          PPinPutWidget(
            isError: isError,
            validatorText: validatorText,
            warningText: warningText,
            label: 'txt_enter_code'.tr.toUpperCase(),
            controller: controller,
            onChange: onChange,
          ),
          const SizedBox(height: 24),
          GestureDetector(
            onTap: onTapResendCode,
            child: RichText(
              text: TextSpan(
                text: 'txt_didnt_get_a_code'.tr.capitalizeFirst!,
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
                children: <InlineSpan>[
                  const WidgetSpan(
                    child: SizedBox(width: 5),
                  ),
                  TextSpan(
                    text: 'txt_resend_code'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.labelLarge!.copyWith(
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'txt_you_can_resend_the_code'.tr.capitalizeFirst!,
            style: Get.theme.textTheme.bodySmall,
          ),
          if (errorMessage != null)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 25.0),
              child: Text(
                errorMessage!,
                style: Get.theme.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w500,
                  color: Get.theme.colorScheme.error,
                ),
              ),
            ),
          const Spacer(),
          PButtonWidget(
            disabled: disabledButton,
            text: 'txt_send_code'.tr.capitalizeFirst!,
            onPressed: onPressed,
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }
}
