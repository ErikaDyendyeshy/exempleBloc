import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/profile/custom_info_model.dart';
import 'package:parallel/_data/model/model/profile/tag_model.dart';
import 'package:parallel/const.dart';

class PMoreAboutUserWidget extends StatelessWidget {
  final String aboutUser;
  final List<CustomInfoModel> customInfo;

  final List<TagModel> tags;

  const PMoreAboutUserWidget({
    super.key,
    required this.aboutUser,
    required this.customInfo,
    required this.tags,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
        child: SingleChildScrollView(
          child: Column(
            children: [
              _aboutMe(),
              const SizedBox(height: 35),
              _myInterest(),
              const SizedBox(height: 12),
              _customInfo()
            ],
          ),
        ));
  }

  Widget _aboutMe() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'txt_about_me'.tr.capitalizeFirst!,
          style: Get.theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 8),
        Text(
          aboutUser,
          style: Get.theme.textTheme.bodyMedium,
        )
      ],
    );
  }

  Widget _myInterest() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'txt_my_interest'.tr.capitalizeFirst!,
          style: Get.theme.textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          ...List<Widget>.generate(
            tags.length,
            (index) => InputChip(
              backgroundColor: Get.theme.colorScheme.surface,
              labelStyle: Get.theme.textTheme.labelLarge!.copyWith(
                fontSize: 14,
              ),
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              label: Text(
                tags[index].tag,
              ),
            ),
          ),
        ]),
      ],
    );
  }

  Widget _customInfo() {
    return customInfo.isNotEmpty
        ? ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: customInfo.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                        customInfo[index].title,
                      style: Get.theme.textTheme.headlineMedium,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      customInfo[index].info,
                      style: Get.theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              );
            },
          )
        : const SizedBox.shrink();
  }
}
