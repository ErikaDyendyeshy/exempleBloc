import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';

class PButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback? onPressed;
  final Widget? leading;
  final Widget? trailing;
  final double? width;
  final double height;
  final double borderRadius;
  final double elevation;
  final Color? colorBorder;
  final TextStyle? textStyle;
  final ShapeBorder? shapeBorder;
  final bool disabled;
  final bool loading;
  final bool autoSize; // only width now
  // final bool borderColor;
  final bool colorTrascparent;
  final bool textButton;
  final String? icon;

  const PButtonWidget({
    Key? key,
    this.text,
    this.width,
    this.onPressed,
    this.leading,
    this.trailing,
    this.colorBorder,
    this.textStyle,
    this.shapeBorder,
    this.height = 48,
    this.elevation = 0,
    this.borderRadius = 8,
    this.disabled = false,
    this.loading = false,
    this.autoSize = false,
    this.colorTrascparent = false,
    this.textButton = false,
    this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AbsorbPointer(
      absorbing: disabled || loading,
      child: Container(
        height: height,
        width: width,
        decoration: textButton == true
            ? null
            : BoxDecoration(
                border: colorTrascparent
                    ? Border.all(color: colorBorder ?? AppColors.gray600)
                    : null,
                gradient: colorTrascparent
                    ? null
                    : LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          disabled ? Get.theme.disabledColor : AppColors.pink,
                          disabled ? Get.theme.disabledColor : AppColors.blue
                        ],
                      ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            disabledBackgroundColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            foregroundColor: AppColors.blue.withOpacity(0.3),
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisSize: autoSize ? MainAxisSize.min : MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (loading) _loading(),
              if (leading != null) _widget(leading!),
              if (icon != null) _middleIcon(),
              if (text != null && !loading)
                Flexible(
                  child: FittedBox(
                    child: Text(
                      text!.capitalizeFirst!,
                      textAlign: TextAlign.center,
                      style: textStyle ??
                          Get.theme.textTheme.displayMedium!.copyWith(
                            color: (disabled)
                                ? AppColors.gray300
                                : colorTrascparent || textButton
                                    ? AppColors.gray600
                                    : AppColors.white,
                          ),
                    ),
                  ),
                ),
              if (trailing != null) _widget(trailing!),
            ],
          ),
        ),
      ),
    );
  }

  Widget _loading() {
    return const SizedBox(
      height: 34,
      width: 34,
      child: CupertinoActivityIndicator(),
    );
  }

  Widget _middleIcon() {
    return PSVGIcon(
      icon: icon!,
      color: disabled ? AppColors.gray400 : AppColors.white,
    );
  }

  Widget _widget(Widget icon) {
    return Padding(
      padding: const EdgeInsets.only(right: 9.0),
      child: icon,
    );
  }
}
