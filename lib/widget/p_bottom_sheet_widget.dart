import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/__.dart';

class PBottomSheetWidget extends StatelessWidget {
  final Widget? child;
  final String? title;
  final String? mediumTitle;
  final String? description;
  final String? textFirstButton;
  final String? textSecondButton;
  final Function()? onPressedFirstButton;
  final Function()? onPressedSecondButton;

  const PBottomSheetWidget({
    Key? key,
    this.child,
    this.title,
    this.mediumTitle,
    this.description,
    this.textFirstButton,
    this.textSecondButton,
    this.onPressedFirstButton,
    this.onPressedSecondButton,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        minHeight: Get.height * 0.2,
        maxHeight: Get.height * 0.8,
      ),
      child: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(14),
              topRight: Radius.circular(14),
            ),
            color: Get.theme.colorScheme.background,
          ),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
            horizontal: 16,
          ),
          child: Column(
            children: [
              Container(
                height: 6,
                width: 48,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: Get.theme.colorScheme.surface,
                ),
              ),
              if (title != null) ...[
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  child: Text(
                    title!,
                    style: Get.theme.textTheme.headlineLarge,
                  ),
                ),
              ],
              if (mediumTitle != null) ...[
                const SizedBox(height: 8),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10.0),
                  child: Text(
                    mediumTitle!,
                    style: Get.theme.textTheme.headlineMedium,
                  ),
                ),
                const SizedBox(height: 8),
              ],
              if (description != null) ...[
                Text(
                  description!,
                  textAlign: TextAlign.center,
                  style: Get.theme.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 16),
              ],
              child ?? const SizedBox.shrink(),
              if (textFirstButton != null && textFirstButton!.isNotEmpty)
                PButtonWidget(
                  text: textFirstButton!,
                  onPressed: onPressedFirstButton,
                ),
              const SizedBox(height: 16),
              if (textSecondButton != null && textSecondButton!.isNotEmpty)
                PButtonWidget(
                  text: textSecondButton!,
                  colorTrascparent: true,
                  onPressed: onPressedSecondButton,
                ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
