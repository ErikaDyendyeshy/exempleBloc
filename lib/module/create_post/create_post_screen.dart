import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/create_post/create_post_controller.dart';
import 'package:parallel/style/app_colors.dart';
import 'package:parallel/widget/__.dart';
import 'package:parallel/widget/p_any_link_widget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';

class CreatePostScreen extends GetView<CreatePostController> {
  const CreatePostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text(
          'txt_create_post'.tr.capitalizeFirst!,
        ),
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.only(
            left: 16.0,
            right: 10,
          ),
          child: GestureDetector(
            onTap: () => Get.back(),
            child: const PSVGIcon(
              icon: 'icon_x',
            ),
          ),
        ),
      ),
      body: _body(),
    );
  }

  Widget _body() {
    return NestedScrollView(
      headerSliverBuilder: (context, value) {
        return [
          SliverAppBar(
            pinned: true,
            automaticallyImplyLeading: false,
            elevation: 0,
            title: TabBar(
              indicatorColor: Get.theme.colorScheme.onPrimary,
              labelStyle: Get.theme.textTheme.labelLarge,
              unselectedLabelColor: Get.theme.colorScheme.onSurface,
              unselectedLabelStyle: Get.theme.textTheme.titleSmall,
              controller: controller.tabController,
              tabs: [
                _tabItem('txt_media'.tr.capitalizeFirst!),
                _tabItem('txt_nft'.tr.toUpperCase()),
                _tabItem('txt_youtube'.tr.capitalizeFirst!),
              ],
            ),
          ),
        ];
      },
      body: TabBarView(
        controller: controller.tabController,
        children: [
          _media(),
          _nft(),
          _youtube(),
        ],
      ),
    );
  }

  Widget _tabItem(String text) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
        text,
        style: Get.theme.textTheme.labelLarge!.copyWith(fontSize: 14),
      ),
    );
  }

  Widget _media() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    Text(
                      'txt_media'.tr.toUpperCase(),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Obx(
                  () => GestureDetector(
                    onTap: () => controller.chooseMedia(),
                    child: controller.mediaRx.value != null && !controller.isMediaLoading.value
                        ? _uploadedFileBody()
                        : controller.isMediaLoading.value
                            ? _mediaPreloader()
                            : Container(
                                height: 220,
                                width: 220,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color: AppColors.grey,
                                ),
                                child: const Center(
                                  child: PSVGIcon(
                                    icon: 'icon_plus',
                                  ),
                                ),
                              ),
                  ),
                ),
                const SizedBox(height: 16),
                PInputTextFieldWidget(
                  controller: controller.textController,
                  labelText: 'txt_description'.tr.toUpperCase(),
                  hintText: 'txt_write_your_text_here'.tr.capitalizeFirst!,
                  maxLength: 4000,
                  maxLines: 5,
                  textInputAction: TextInputAction.next,
                ),
              ],
            ),
            Column(
              children: [
                Obx(
                  () => PButtonWidget(
                    disabled: controller.isLoading.value,
                    loading: controller.isLoading.value,
                    onPressed: () => controller.createMediaPost(),
                    text: 'txt_publish_post'.tr,
                  ),
                ),
                const SizedBox(height: 50)
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _nft() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          PInputTextFieldWidget(
            labelText: 'txt_add_nft_link'.tr.toUpperCase(),
            controller: controller.nftLinkController,
          ),
          const SizedBox(height: 16),
          PInputTextFieldWidget(
            controller: controller.textController,
            labelText: 'txt_description'.tr.toUpperCase(),
            hintText: 'txt_write_your_text_here'.tr.capitalizeFirst!,
            maxLength: 4000,
            maxLines: 5,
          ),
          const Spacer(),
          PButtonWidget(
            onPressed: () => controller.createMediaPost(),
            text: 'txt_publish_post'.tr,
          ),
          const SizedBox(height: 50),
        ],
      ),
    );
  }

  Widget _youtube() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Obx(
        () => Column(
          children: [
            PInputTextFieldWidget(
              labelText: 'txt_add_youtube_link'.tr.toUpperCase(),
              controller: controller.insertLinkController,
              onChanged: (value) {
                controller.checkInputLink(value);
              },
            ),
            const SizedBox(height: 16),
            PInputTextFieldWidget(
              controller: controller.textController,
              labelText: 'txt_description'.tr.toUpperCase(),
              hintText: 'txt_write_your_text_here'.tr.capitalizeFirst!,
              maxLength: 4000,
              maxLines: 5,
            ),
            if (controller.showLink.isNotEmpty) _anyLink(),
            const Spacer(),
            PButtonWidget(
              onPressed: () => controller.createYoutubePost(),
              text: 'txt_publish_post'.tr,
            ),
            const SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget _anyLink() {
    return PAnyLinkWidget(
      link: controller.showLink.value,
      onTap: controller.removeLink,
    );
  }

  Widget _uploadedFileBody() {
    return controller.isImage.value ? _image() : _video();
  }

  Widget _image() {
    return SizedBox(
      width: 220,
      height: 220,
      child: Image.file(
        controller.mediaRx.value!,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _mediaPreloader() {
    return SizedBox(
      height: 220,
      width: 220,
      child: SkeletonAvatar(
        style: SkeletonAvatarStyle(
          shape: BoxShape.rectangle,
          height: controller.mediaHeight.value,
          width: Get.width,
        ),
      ),
    );
  }

  Widget _video() {
    return Obx(
      () => SizedBox(
        width: controller.isVerticalMedia.value ? 300 : Get.width,
        height: controller.isVerticalMedia.value ? 500 : controller.mediaHeight.value,
        child: AspectRatio(
          aspectRatio: controller.videoPlayerController.value.aspectRatio,
          child: VideoPlayer(
            controller.videoPlayerController,
          ),
        ),
      ),
    );
  }
}
