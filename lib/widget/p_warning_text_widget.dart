import 'package:flutter/material.dart';
import 'package:parallel/style/app_colors.dart';

class PWarningTextWidget extends StatelessWidget {
  final Color warningColor;
  final String warningMessage;
  final IconData? warningIcon;

  const PWarningTextWidget({
    super.key,
    this.warningColor = AppColors.red,
    required this.warningMessage,
    this.warningIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (warningIcon != null) ...[
          Icon(
            warningIcon!,
            color: warningColor,
            size: 16,
          ),
          const SizedBox(
            width: 5,
          ),
        ],
        Expanded(
          child: Text(
            warningMessage,
            style: TextStyle(
              fontFamily: 'SF-Pro-Text',
              color: warningColor,
              fontSize: 11,
              fontWeight: FontWeight.w400,
              letterSpacing: .4,
            ),
          ),
        ),
      ],
    );
  }
}
