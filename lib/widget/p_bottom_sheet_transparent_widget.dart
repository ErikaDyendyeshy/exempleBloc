import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PBottomSheetTransparentWidget extends StatelessWidget {
  final Function()? onTapFirstButton;
  final Function()? onTapSecondButton;
  final Function()? onCancel;
  final String textFirstButton;
  final String? textSecondButton;

  const PBottomSheetTransparentWidget({
    super.key,
    this.onTapFirstButton,
    this.onTapSecondButton,
    this.onCancel,
    required this.textFirstButton,
    this.textSecondButton,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Column(
              children: [
                GestureDetector(
                  onTap: onTapFirstButton,
                  child: SizedBox(
                    height: 50,
                    child: Center(
                      child: Text(
                        textFirstButton,
                        style: Get.theme.textTheme.headlineLarge!.copyWith(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          color: Get.theme.colorScheme.error,
                        ),
                      ),
                    ),
                  ),
                ),
                textSecondButton != null
                    ? const Divider(
                        height: 0,
                      )
                    : const SizedBox.shrink(),
                textSecondButton != null
                    ? GestureDetector(
                        onTap: onTapSecondButton,
                        child: SizedBox(
                          height: 50,
                          child: Center(
                            child: Text(
                              textSecondButton ?? '',
                              style: Get.theme.textTheme.headlineLarge!.copyWith(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: Get.theme.colorScheme.error,
                              ),
                            ),
                          ),
                        ),
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              right: 16,
              left: 16,
              bottom: 16,
            ),
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.background,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: GestureDetector(
              onTap: onCancel,
              child: SizedBox(
                height: 50,
                child: Center(
                  child: Text(
                    'txt_cancel'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.headlineLarge!.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
