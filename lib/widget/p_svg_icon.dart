import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PSVGIcon extends StatelessWidget {
  final String icon;
  final Color? color;
  final Function()? onTap;
  final double? width;
  final double? height;

  const PSVGIcon({
    required this.icon,
    this.color,
    this.onTap,
    super.key,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SvgPicture.asset(
        'assets/icon/$icon.svg',
        width: width,
        height: height,
        color: color,
      ),
    );
  }
}
