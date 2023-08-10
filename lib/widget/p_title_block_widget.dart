import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PTitleBlockWidget extends StatelessWidget {
  final String? title;
  final String? description;

  const PTitleBlockWidget({
    super.key,
    this.title,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        if (title != null)
          Text(
            title!.tr.capitalizeFirst!,
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.headlineLarge,
          ),
        const SizedBox(height: 12),
        if (description != null)
          Text(
            description!.tr.capitalizeFirst!,
            style: Get.theme.textTheme.bodyMedium,
            textAlign: TextAlign.center,
          ),
      ],
    );
  }
}
