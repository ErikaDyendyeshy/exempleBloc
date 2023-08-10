import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/short_person_model_temp/short_person_model_temp.dart';
import 'package:parallel/module/search/search_controller.dart';
import 'package:parallel/widget/p_avatar_widget.dart';
import 'package:parallel/widget/p_list_view_widget.dart';

class ListResult extends GetView<SearchController> {
  const ListResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => controller.isLoading.value
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : PListViewWidget(
              onEndOfPage: () => controller.loadMoreUsers(),
              count: controller.userListRx.length,
              onBuildItem: (index) => _itemResult(controller.userListRx[index]),
            ),
    );
  }

  Widget _itemResult(ShortPersonModel person) {
    return GestureDetector(
      onTap: () => controller.openProfile(personId: person.id),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: Get.theme.colorScheme.background,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  PAvatarWidget(
                    height: 80,
                    width: 80,
                    avatarUrl: person.avatarUrl,
                  ),
                  const SizedBox(width: 16),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        person.name,
                        maxLines: 1,
                        style: Get.theme.textTheme.headlineMedium,
                      ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: '0',
                              style: Get.theme.textTheme.headlineMedium,
                              children: <InlineSpan>[
                                const WidgetSpan(
                                  child: SizedBox(width: 5),
                                ),
                                TextSpan(
                                  text: 'txt_followers'.tr.capitalizeFirst!,
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          VerticalDivider(
                            width: 30,
                            color: Get.theme.colorScheme.surface,
                            thickness: 2,
                          ),
                          RichText(
                            text: TextSpan(
                              text: '0',
                              style: Get.theme.textTheme.headlineMedium,
                              children: <InlineSpan>[
                                const WidgetSpan(
                                  child: SizedBox(width: 5),
                                ),
                                TextSpan(
                                  text: 'txt_following'.tr.capitalizeFirst!,
                                  style:
                                      Get.theme.textTheme.bodyMedium!.copyWith(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Text(
                'about me',
                style: Get.theme.textTheme.labelLarge!.copyWith(fontSize: 14),
                textAlign: TextAlign.left,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
