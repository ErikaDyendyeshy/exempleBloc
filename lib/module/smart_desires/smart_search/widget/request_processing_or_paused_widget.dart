import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/smart_desires/smart_search/smart_search_controller.dart';
import 'package:parallel/module/smart_desires/smart_search/widget/item_request_widget.dart';
import 'package:parallel/widget/__.dart';

class RequestProcessingOrPausedWidget extends GetView<SmartSearchController> {
  const RequestProcessingOrPausedWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: horizontalPaddingScreen,
      ),
      child: Obx(
        () => controller.requestDetailRx.value == null
            ? const CircularProgressIndicator()
            : SizedBox(
                height: Get.height,
                child: Stack(
                  children: [
                    ConstrainedBox(
                      constraints: const BoxConstraints(
                        maxHeight: 550,
                        minHeight: 300,
                      ),
                      child: Obx(
                        () => Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            controller.pausedRequestRx.value
                                ? ItemRequestWidget(
                                    status: 'txt_paused'.tr.capitalizeFirst!,
                                  )
                                : ItemRequestWidget(
                                    status: 'txt_processing'.tr.capitalizeFirst!,
                                  ),
                            controller.pausedRequestRx.value
                                ? const Padding(
                                    padding: EdgeInsets.only(
                                      top: 16.0,
                                      bottom: 12,
                                    ),
                                    child: PSVGIcon(icon: 'icon_toggle_pause'),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.symmetric(vertical: 30.0),
                                    child: SizedBox(
                                      height: 120,
                                      child: Lottie.asset('assets/lottie/lf20_vrU7JG.json'),
                                    ),
                                  ),
                            controller.pausedRequestRx.value
                                ? Text(
                                    'txt_your_search_is_currently_on_hold'.tr,
                                    style: Get.theme.textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  )
                                : Text(
                                    'txt_it_may_take_some_time'.tr,
                                    style: Get.theme.textTheme.titleLarge,
                                    textAlign: TextAlign.center,
                                  ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 100,
                      left: 0,
                      right: 0,
                      child: controller.pausedRequestRx.value
                          ? PButtonWidget(
                              text: 'txt_resume_searching'.tr.capitalizeFirst!,
                              onPressed: () {
                                controller.togglePauseRequest(
                                  requestId: controller.requestDetailRx.value!.request.id,
                                );
                              },
                            )
                          : PButtonWidget(
                              colorTrascparent: true,
                              text: 'txt_pause_searching'.tr.capitalizeFirst!,
                              onPressed: () {
                                controller.togglePauseRequest(
                                  requestId: controller.requestDetailRx.value!.request.id,
                                );
                              },
                            ),
                    )
                  ],
                ),
              ),
      ),
    );
  }
}
