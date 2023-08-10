import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/file_model.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/util/get_media_mixin.dart';
import 'package:parallel/widget/p_bottom_sheet_widget.dart';
import 'package:parallel/widget/p_choose_type_media.dart';

class CreatePostController extends GetxController
    with GetSingleTickerProviderStateMixin, GetMediaMixin {
  final ProfileRepository _profileRepository = Get.find();
  late TabController tabController;
  final TextEditingController textController = TextEditingController();
  final TextEditingController nftLinkController = TextEditingController();
  final TextEditingController youtubeLinkController = TextEditingController();
  final Rx<FileModel?> fileUrl = Rx(null);
  final RxInt type = 0.obs;
  final RxBool isLoading = false.obs;

  CreatePostController() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  void chooseMedia() {
    Get.bottomSheet(
      PBottomSheetWidget(
        child: PChooseTypeMedia(
          getImage: () => getImage(),
          getVideo: () => getVideo(),
        ),
      ),
    );
  }

  Future createMediaPost() async {
    isLoading.value = true;
    if (mediaRx.value != null) {
      final compressedMedia = await compressMedia(mediaRx.value!);
      if (mediaRx.value!.path.isImageFileName == true ||
          mediaRx.value!.path.isVideoFileName == true) {
        fileUrl.value = await _profileRepository.sendFile(
          filePath: compressedMedia.toString(),
        );
        if (mediaRx.value!.path.isImageFileName == true) {
          type.value = 1;
        } else if (mediaRx.value!.path.isVideoFileName == true) {
          type.value = 2;
        }
      } else {
        type.value = 0;
      }
    }
    _profileRepository
        .createPost(
      text: textController.text.isEmpty ? '' : textController.text,
      mediaUrl: fileUrl.value == null ? '' : fileUrl.value!.file,
      type: type.value,
      nftLink: '',
    )
        .then((value) {
      Get.back();
      Get.showSuccessMessage(
          'txt_you_successfully_published_post'.tr.capitalizeFirst!);
      isLoading.value = false;

    });
    isLoading.value = false;

  }

  Future createNftPost() async {
    _profileRepository
        .createPost(
      text: textController.text.isEmpty ? '' : textController.text,
      type: type.value,
      nftLink: nftLinkController.text.isEmpty ? '' : nftLinkController.text,
    )
        .then((value) {
      Get.back();
      Get.showSuccessMessage(
          'txt_you_successfully_published_post'.tr.capitalizeFirst!);
    });
  }

  Future createYoutubePost() async {
    _profileRepository
        .createPost(
            text: textController.text.isEmpty ? '' : textController.text,
            mediaUrl: insertLinkController.text,
            type: 3,
            nftLink: '')
        .then((value) {
      Get.back();
      Get.showSuccessMessage(
          'txt_you_successfully_published_post'.tr.capitalizeFirst!);
    });
  }
}
