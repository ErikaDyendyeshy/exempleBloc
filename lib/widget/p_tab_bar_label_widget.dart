import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:parallel/style/app_colors.dart';

class TabBarLabelWidget extends StatelessWidget {
  final String text;
  final double height;
  final bool isSelected;
  const TabBarLabelWidget({
    required this.text,
    required this.isSelected,
    this.height = 40,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: Center(
        child: Text(
          text.capitalizeFirst!,
          style: isSelected
              ? Get.theme.textTheme.labelLarge!.copyWith(fontSize: 14)
              : Get.theme.textTheme.bodyMedium!
                  .copyWith(color: AppColors.gray400),
        ),
      ),
    );
  }
}
