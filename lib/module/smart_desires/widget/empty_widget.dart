import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/widget/__.dart';

class EmptyWidget extends StatelessWidget {
  final String icon;
  final String text;

  const EmptyWidget({
    super.key,
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 170),
        PSVGIcon(icon: icon),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: Get.theme.textTheme.titleLarge!.copyWith(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}
