import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/const.dart';
import 'package:parallel/module/search/search_controller.dart';
import 'package:parallel/module/search/widget/list_result_widget.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';

class SearchScreen extends GetView<SearchController> {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _body(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return PreferredSize(
      preferredSize: const Size.fromHeight(130.0),
      child: Container(
        width: Get.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.pink, AppColors.blue],
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Row(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: PSVGIcon(
                            icon: 'icon_arrow_left',
                            onTap: () => controller.getBack(),
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          'txt_search'.tr.capitalizeFirst!,
                          style: Get.theme.textTheme.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
              ),
              child: Obx(
                () => PInputTextFieldWidget(
                  trailingIcon: controller.searchTextRx.isNotEmpty ? 'icon_x' : 'icon_search',
                  hintText: 'txt_search'.tr.capitalizeFirst,
                  controller: controller.searchController,
                  colorIcon: Get.theme.colorScheme.onSurface,
                  trailingOnTap: () => controller.clearSearchField(),
                  onChanged: (search) => controller.search(search),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  Widget _body() {
    return Obx(
      () => controller.userListRx.isEmpty ? _emptyList() : const ListResult(),
    );
  }

  Widget _emptyList() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: horizontalPaddingScreen),
        child: controller.searchTextRx.isEmpty
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const PSVGIcon(icon: 'icon_search_gradient'),
                  const SizedBox(height: 15),
                  Text(
                    'txt_here_you_will_find_the_results_of_your_search'.tr.capitalizeFirst!,
                    style: Get.theme.textTheme.titleLarge!.copyWith(fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              )
            : Text(
                'txt_user_not_found_or_does_not_exist'.tr.capitalizeFirst!,
                style: Get.theme.textTheme.titleLarge!.copyWith(fontSize: 14),
                textAlign: TextAlign.center,
              ),
      ),
    );
  }
}
