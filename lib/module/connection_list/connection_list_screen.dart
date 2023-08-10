import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/connection_list/connection_list_controller.dart';
import 'package:parallel/module/connection_list/widget/connection_widget.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_tab_bar_label_widget.dart';

class ConnectionListScreen extends GetView<ConnectionListController> {
  const ConnectionListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: () => controller.getBack(),
          child: const Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 14,
            ),
            child: PSVGIcon(
              icon: 'icon_arrow_left',
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          controller.selfProfile.value!.user.name,
        ),
        elevation: 0,
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Column(
      children: [
        Container(
          decoration: BoxDecoration(
            color: context.theme.scaffoldBackgroundColor,
            border: const Border(
              bottom: BorderSide(
                width: 2.5,
                color: AppColors.gray100,
              ),
            ),
          ),
          height: 50,
          child: TabBar(
            controller: controller.tabController,
            indicatorColor: AppColors.black,
            indicatorWeight: 3,
            tabs: [
              Obx(
                () => TabBarLabelWidget(
                  text:
                      '${controller.relationsCountRx.value == null ? '0' : controller.relationsCountRx.value!.followersCount} ${'txt_followers'.tr.capitalizeFirst!}',
                  isSelected: controller.tabController.index == 0 ? true : false,
                ),
              ),
              Obx(
                () => TabBarLabelWidget(
                  text:
                      '${controller.relationsCountRx.value == null ? '0' : controller.relationsCountRx.value!.followingCount} ${'txt_following'.tr.capitalizeFirst!}',
                  isSelected: controller.tabController.index == 1 ? true : false,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: TabBarView(
            controller: controller.tabController,
            children: [
              Obx(
                () => controller.followersListRx.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.followersListRx.length,
                        itemBuilder: (context, index) => ConnectionWidget(
                          key: ValueKey(controller.followersListRx[index].id),
                          connection: controller.followersListRx[index],
                          followersList: true,
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 200),
                          const PSVGIcon(icon: 'icon_followers_gradient'),
                          const SizedBox(height: 15),
                          Text(
                            'txt_here_you_can_see_all_users_who_will_follow_you'.tr.capitalizeFirst!,
                            style: Get.theme.textTheme.titleLarge!.copyWith(
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
              ),
              Obx(
                () => controller.followingListRx.isNotEmpty
                    ? ListView.builder(
                        itemCount: controller.followingListRx.length,
                        itemBuilder: (context, index) => ConnectionWidget(
                          key: ValueKey(controller.followingListRx[index].id),
                          followersList: false,
                          connection: controller.followingListRx[index],
                        ),
                      )
                    : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(height: 200),
                            const PSVGIcon(icon: 'icon_followers_gradient'),
                            const SizedBox(height: 15),
                            Text(
                              'txt_when_you_begin_following_someone_they_will_be_displayed_here'.tr.capitalizeFirst!,
                              textAlign: TextAlign.center,
                              style: Get.theme.textTheme.titleLarge!.copyWith(
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
