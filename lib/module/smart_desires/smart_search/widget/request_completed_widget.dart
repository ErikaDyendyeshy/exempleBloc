import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/person_model.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/smart_desires/smart_search/smart_search_controller.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_list_view_widget.dart';

class RequestCompletedWidget extends GetView<SmartSearchController> {
  const RequestCompletedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingScreen,
      ),
      child: Obx(
        () => controller.requestDetailRx.value == null
            ? const CircularProgressIndicator()
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => controller.startAnimation.value =
                        !controller.startAnimation.value,
                    child: Obx(
                      () => AnimatedSize(
                        duration: const Duration(milliseconds: 700),
                        alignment: Alignment.topCenter,
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 20,
                            horizontal: 12,
                          ),
                          height: controller.startAnimation.value ? null : 88,
                          decoration: BoxDecoration(
                            color: Get.theme.colorScheme.background,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                Flexible(
                                  flex: 8,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Completed!',
                                        style: Get.theme.textTheme.titleLarge!
                                            .copyWith(
                                          color: Get.theme.colorScheme.tertiary,
                                        ),
                                      ),
                                      const SizedBox(height: 15),
                                      Text(
                                        controller.requestDetailRx.value!
                                            .request.request,
                                        maxLines:
                                            controller.startAnimation.value
                                                ? 25
                                                : 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: Get
                                            .theme.textTheme.headlineMedium!
                                            .copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(width: 10),
                                Flexible(
                                  flex: 1,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: const [
                                      Padding(
                                        padding: EdgeInsets.only(top: 15.0),
                                        child:
                                            PSVGIcon(icon: 'icon_carret_down'),
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'txt_results'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  PListViewWidget(
                      count: controller.requestDetailRx.value!.results.length,
                      onBuildItem: (int index) {
                        return _itemResult(
                          controller.requestDetailRx.value!.results[index],
                        );
                      }),
                ],
              ),
      ),
    );
  }

  Widget _itemResult(PersonModel person) {
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

                      // if (person.country.isNotEmpty)
                      //   const SizedBox(height: 5),
                      // if (controller.selfProfile.value!.user.country.isNotEmpty)
                      //   Text(
                      //     controller.selfProfile.value!.user.country,
                      //     maxLines: 1,
                      //     style: Get.theme.textTheme.bodyMedium!.copyWith(
                      //       fontWeight: FontWeight.w500,
                      //     ),
                      //   ),
                      const SizedBox(height: 15),
                      Row(
                        children: [
                          RichText(
                            text: TextSpan(
                              text: person.followers.toString(),
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
                              text: person.following.toString(),
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
                person.aboutMe,
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
