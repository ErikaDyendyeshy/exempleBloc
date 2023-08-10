import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/botton_navigation/bottom_bar_menu_item.dart';

class PBottomNavigationWidget extends StatelessWidget {
  final int? currentIndex;
  final List<BottomBarMenuItem> items;
  final bool isContractor;

  const PBottomNavigationWidget({
    super.key,
    this.currentIndex,
    this.isContractor = false,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: context.theme.colorScheme.background,
      elevation: 5,
      notchMargin: 5,
      shape: const CircularNotchedRectangle(),
      child: SizedBox(
        height: Platform.isAndroid ? 70 : 56,
        child: isContractor
            ? Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...items.sublist(0, items.length),
                ],
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ...items.sublist(0, items.length ~/ 2),
                  const SizedBox(width: 40),
                  ...items.sublist(items.length ~/ 2, items.length),
                ],
              ),
      ),
    );
  }
}
