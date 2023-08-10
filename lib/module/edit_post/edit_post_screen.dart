import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/module/edit_post/edit_post_controller.dart';
import 'package:parallel/module/post/post_detail/widget/post_skeleton.dart';
import 'package:parallel/widget/p_button_widget.dart';
import 'package:parallel/widget/p_input_text_widget.dart';
import 'package:skeletons/skeletons.dart';
import 'package:video_player/video_player.dart';

class EditPostScreen extends GetView<EditPostController> {
  const EditPostScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Get.theme.scaffoldBackgroundColor,
        title: Text('txt_edit_post'.tr.capitalizeFirst!),
        elevation: 0,
      ),
      body: Obx(
        () => controller.isPostLoading.value ? const PostSkeleton() : _body(),
      ),
    );
  }

  Widget _body() {
    return Padding(
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
              GestureDetector(
                child: !controller.isPostLoading.value
                    ? _uploadedFileBody()
                    : _mediaPreloader(),
              ),
              const SizedBox(height: 16),
              PInputTextFieldWidget(
                controller: controller.textController,
                labelText: 'txt_description'.tr.toUpperCase(),
                hintText: 'txt_write_your_text_here'.tr.capitalizeFirst!,
                maxLength: 4000,
                maxLines: 5,
              ),
            ],
          ),
          Column(
            children: [
              PButtonWidget(
                onPressed: () => controller.editPost(),
                text: 'txt_save'.tr,
              ),
              const SizedBox(height: 30)
            ],
          ),
        ],
      ),
    );
  }

  Widget _uploadedFileBody() {
    return Column(
      children: [
        !controller.post.isVideoPost ? _image() : _video(),
        if (controller.isPostLoading.value)
          Container(
            decoration: BoxDecoration(
              color: Get.theme.colorScheme.tertiary.withOpacity(0.9),
            ),
            width: 220,
            height: 220,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 40,
                  width: 40,
                  child: CircularProgressIndicator(
                    color: Get.theme.textTheme.titleSmall!.color,
                    strokeWidth: 3,
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  Widget _image() {
    return SizedBox(
      width: 220,
      height: 220,
      child: Image.network(
        controller.post.mediaUrl,
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
        width: Get.width,
        height: controller.mediaHeight.value,
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
