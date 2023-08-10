import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/__.dart';

class BottomBarMenuItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  final String iconAssetName;
  final Color colorItem;

  const BottomBarMenuItem({
    Key? key,
    required this.title,
    required this.onTap,
    required this.iconAssetName,
    required this.colorItem,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: onTap,
      child: SizedBox(
        width: Get.width * 0.2,
        child: Column(
          mainAxisAlignment: Platform.isAndroid ? MainAxisAlignment.center : MainAxisAlignment.end,
          children: [
            PSVGIcon(
              icon: iconAssetName,
              color: colorItem,
            ),
            const SizedBox(height: 6),
            Text(
              title,
              style: Get.textTheme.bodySmall!.copyWith(
                color: colorItem,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
