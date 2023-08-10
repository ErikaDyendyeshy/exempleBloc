import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/p_svg_icon.dart';

class PInputTextFieldWidget extends StatelessWidget {
  // ----------label----------
  final String? labelText;
  final bool optional;

  // -------input field-------
  final EdgeInsetsGeometry? margin;
  final FocusNode? focusNode;
  final bool readOnly;
  final bool autofocus;
  final double borderRadius;
  final double height;
  final int? maxLength;
  final int maxLines;
  final TextEditingController? controller;
  final TextStyle? textStyle;
  final bool? obscureText;
  final String? hintText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final String? leadingIcon;
  final Color? leadingIconColor;
  final String? trailingIcon;
  final Color? trailingIconColor;
  final Color? colorIcon;

  //--------description --------
  final String? description;

  // --------validator--------
  final bool? validatorEnable;
  final bool fieldError;
  final bool? validatorShowIcon;
  final Color? validatorErrorColor;
  final String? validatorText;
  final TextStyle? validatorTextStyle;

  // -------- function ---------
  final ValueChanged<String>? onChanged;
  final void Function()? trailingOnTap;
  final Function()? onTap;
  final void Function(String)? onSubmitted;
  final void Function()? leadingOnTap;

  const PInputTextFieldWidget({
    super.key,
    this.labelText,
    this.focusNode,
    this.optional = false,
    this.readOnly = false,
    this.autofocus = false,
    this.margin,
    this.maxLines = 1,
    this.borderRadius = 12,
    this.height = 8,
    this.controller,
    this.textStyle,
    this.obscureText,
    this.hintText,
    this.keyboardType,
    this.textInputAction,
    this.inputFormatters,
    this.onSubmitted,
    this.onChanged,
    this.leadingIcon,
    this.trailingIcon,
    this.maxLength,
    this.leadingIconColor,
    this.colorIcon,
    this.leadingOnTap,
    this.onTap,
    this.trailingIconColor,
    this.trailingOnTap,
    this.validatorEnable,
    this.fieldError = false,
    this.validatorShowIcon,
    this.validatorErrorColor,
    this.validatorText,
    this.validatorTextStyle,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        _label(),
        _inputField(),
        _description(),
        _validator(),
      ],
    );
  }

  Widget _label() {
    return Visibility(
      visible: labelText != null,
      child: Column(
        children: [
          Row(
            children: [
              Text(
                labelText ?? '',
                style: Get.theme.textTheme.labelLarge,
              ),
              const SizedBox(width: 5),
              Text(
                optional == true ? 'txt_optional'.tr.toUpperCase() : '',
                style: Get.theme.textTheme.labelLarge!.copyWith(
                  color: AppColors.gray300,
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _inputField() {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 300.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(
            color: (validatorEnable ?? false) ? AppColors.red : Colors.transparent,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: TextField(
                focusNode: focusNode,
                maxLines: maxLines,
                readOnly: readOnly,
                controller: controller,
                onSubmitted: onSubmitted,
                onChanged: onChanged,
                onTap: onTap,
                minLines: 1,
                autofocus: autofocus,
                autocorrect: false,
                enableSuggestions: false,
                obscureText: obscureText ?? false,
                keyboardType: keyboardType,
                textInputAction: textInputAction,
                inputFormatters: inputFormatters,
                maxLength: maxLength,
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderRadius: const BorderRadius.all(Radius.circular(12.0)),
                    borderSide: BorderSide(
                      color: validatorEnable == false ? AppColors.gray600 : Colors.transparent,
                    ),
                  ),
                  hintText: hintText,
                  suffixIcon: trailingIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 8,
                            right: 10,
                          ),
                          child: GestureDetector(
                            onTap: trailingOnTap,
                            child: PSVGIcon(
                              icon: trailingIcon!,
                              color: colorIcon,
                            ),
                          ),
                        )
                      : null,
                  prefixIcon: leadingIcon != null
                      ? Padding(
                          padding: const EdgeInsets.only(
                            left: 10,
                            right: 15,
                          ),
                          child: GestureDetector(
                            onTap: leadingOnTap,
                            child: SizedBox(
                              height: 20,
                              width: 20,
                              child: PSVGIcon(
                                icon: leadingIcon!,
                                color: colorIcon,
                              ),
                            ),
                          ),
                        )
                      : null,
                  filled: validatorText != null ? false : true,
                  fillColor: AppColors.gray100,
                ),
                style: textStyle ??
                    Get.theme.textTheme.labelLarge!.copyWith(
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _description() {
    return Visibility(
      visible: description != null,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 6,
          bottom: 6,
        ),
        child: Text(
          description ?? '',
          style: Get.textTheme.bodyMedium!.copyWith(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _validator() {
    return Visibility(
      visible: validatorText != null,
      child: IntrinsicHeight(
        child: Row(
          children: [
            const Align(
              alignment: Alignment.topCenter,
              child: SizedBox(
                width: 12,
                child: PSVGIcon(
                  icon: 'icon_warning',
                  color: AppColors.red,
                ),
              ),
            ),
            const SizedBox(width: 4),
            Flexible(
              child: Text(
                validatorText ?? '',
                style: Get.theme.inputDecorationTheme.errorStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
