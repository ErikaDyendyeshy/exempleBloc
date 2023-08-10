import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/smart_desires/smart_search/smart_search_controller.dart';
import 'package:parallel/widget/__.dart';

class ItemRequestWidget extends GetView<SmartSearchController> {
  final String status;

  const ItemRequestWidget({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => controller.startAnimation.value = !controller.startAnimation.value,
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          status,
                          style: Get.theme.textTheme.titleLarge,
                        ),
                        const SizedBox(height: 15),
                        Text(
                          controller.requestDetailRx.value!.request.request,
                          maxLines: controller.startAnimation.value ? 25 : 1,
                          overflow: TextOverflow.ellipsis,
                          style: Get.theme.textTheme.headlineMedium!.copyWith(
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
                          child: PSVGIcon(icon: 'icon_carret_down'),
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
    );
  }
}
