import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';

mixin GetMediaMixin on GetxController {
  final Rx<File?> mediaRx = Rx(null);
  final Rx<File?> file = Rx(null);
  final RxDouble mediaHeight = (Get.width * 0.5).obs;
  final RxDouble aspectRatio = 0.56.obs;
  final RxString showLink = ''.obs;
  final RxBool isImage = true.obs;
  final RxBool isMediaLoading = false.obs;
  final RxBool isVideoInizialized = false.obs;
  final RxBool islinkValid = true.obs;
  final RxBool isVerticalMedia = false.obs;
  final TextEditingController insertLinkController = TextEditingController();
  late final VideoPlayerController videoPlayerController;

  final int sizedPicture =
      1024 * 1024 * 5; //check picture size = 5mb (1024*1024*5)

  Future getImage() async {
    Get.back();

    FilePickerResult? filePickerResult = await FilePicker.platform.pickFiles(
      type: FileType.image,
      onFileLoading: (p0) => isMediaLoading.value = true,
    );
    if (filePickerResult == null) return;

    MediaResult? mediaResult =
        await getCropImageMixin(File(filePickerResult.files.single.path!))
            .then((String? cropedFile) {
      return cropedFile != null
          ? MediaResult(
              file: File(cropedFile),
              type: FileType.image,
            )
          : null;
    });
    if (mediaResult == null) {
      isMediaLoading.value = false;
      return;
    }


      mediaRx.value = mediaResult.file;
      isImage.value = true;
      _getImageSize(mediaResult.file);


    isMediaLoading.value = false;
  }

  void _getImageSize(File file) {
    Image image = Image.file(file);
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener(
        (ImageInfo image, bool synchronousCall) {
          double imageHeight =
              Size(image.image.width.toDouble(), image.image.height.toDouble())
                  .height;
          double imageWidth =
              Size(image.image.width.toDouble(), image.image.height.toDouble())
                  .width;
          checkImageScale(imageHeight, imageWidth);
        },
      ),
    );
  }

  Future<String?> getCropImageMixin(File? pickedFile) async {
    if (pickedFile != null) {
      final cropedFile = await ImageCropper().cropImage(
        sourcePath: pickedFile.path,
        compressFormat: ImageCompressFormat.jpg,
        compressQuality: 100,
        uiSettings: [
          AndroidUiSettings(
            toolbarTitle: 'txt_edit_your_image'.tr,
            hideBottomControls: true,
            lockAspectRatio: false,
            initAspectRatio: CropAspectRatioPreset.original,
          ),
          IOSUiSettings(
            title: 'txt_edit_your_image'.tr,
            hidesNavigationBar: true,
            minimumAspectRatio: 0.5625,
            aspectRatioPickerButtonHidden: true,
          ),
        ],
      );
      if (cropedFile != null) {
        return cropedFile.path;
      }
    }
    return null;
  }

  void checkImageScale(double imageHeight, double imageWidth) {
    if (imageHeight / imageWidth < 0.56 || imageWidth / imageHeight < 0.56) {
      mediaRx.value = null;
      Get.showErrorMessage('txt_the_size_of_the_image_is_inappropriate'.tr, '');
      return;
    }
    if (imageHeight < 180 || imageWidth < 320) {
      mediaRx.value = null;
      Get.showErrorMessage('txt_image_should_not_be_less_than'.tr, '');
      return;
    }
    calcVideoHeightByWidth(imageHeight, imageWidth);
  }

  double calcVideoHeightByWidth(double height, double width) {
    aspectRatio.value = width / height;
    return mediaHeight.value = height / width * (Get.width);
  }

  Future getVideo() async {
    Get.back();

    await FilePicker.platform
        .pickFiles(
      type: FileType.video,
      onFileLoading: (p0) => isMediaLoading.value = true,
    )
        .then((FilePickerResult? result) {
      if (result != null) {
        MediaResult mediaResult = MediaResult(
          file: File(result.files.single.path!),
          type: FileType.video,
        );
        double videoSize = result.files.first.size / 1024 / 1024;
        if (videoSize < 512) {
          isImage.value = false;
          mediaRx.value = mediaResult.file;
          initializePlayer(mediaRx.value);
        } else {
          mediaRx.value = null;
          Get.showErrorMessage('txt_video_should_not_be_bigger_that'.tr, '');
        }
      }
      isMediaLoading.value = false;
    });
  }

  Future<String?> compressMedia(File mediaFile) async {
    if (isImage.value) {
      final compressedFile = await FlutterImageCompress.compressAndGetFile(
        mediaFile.path,
        mediaFile.path.replaceFirst('.jpg', '_compressed.jpg'),
        quality: 88,
      );

      return compressedFile!.path;
    } else {
      // Compress video
      final info = await VideoCompress.compressVideo(
        mediaFile.path,
        quality: VideoQuality.DefaultQuality,
        deleteOrigin: false,
      );

      if (info == null) {
        // Compression failed, handle the error here if needed
        Get.showErrorMessage('txt_video_compression_failed'.tr, '');
        return null;
      }

      return info.path;
    }
  }

  Future<void> initializePlayer(File? file) async {
    if (file != null) {
      videoPlayerController = VideoPlayerController.file(file);

      videoPlayerController.initialize().then((value) {
        isVideoInizialized.value = true;
        videoPlayerController.setVolume(0);
        videoPlayerController.play();
        videoPlayerController.setLooping(true);
        calcVideoHeightByWidth(
          videoPlayerController.value.size.height,
          videoPlayerController.value.size.width,
        );
        if (videoPlayerController.value.size.height > videoPlayerController.value.size.width
        ) {
          isVerticalMedia.value = true;
        } else {
          isVerticalMedia.value = false;
        }
        if (videoPlayerController.value.size.height > 1980 ||
            videoPlayerController.value.size.width > 1980) {
          mediaRx.value = null;
          isVideoInizialized.value = false;
          videoPlayerController.dispose();
          Get.showErrorMessage(
              'txt_video_should_not_be_bigger_that_1980_pixels'.tr, '');
        }
      }).onError((error, stackTrace) {
        isVideoInizialized.value = false;
        videoPlayerController.dispose();
      });
    }
  }

  void removeMedia() {
    if (mediaRx.value != null && !isImage.value) {
      videoPlayerController.pause();
      videoPlayerController.dispose();
    }
    mediaRx.value = null;
  }

  void removeLink() {
    showLink.value = '';
    insertLinkController.clear();
  }

  void checkInputLink(String text) {
    showLink.value = text;
  }
  // void openAddLinkBS() {
  //   Get.back();
  //   Get.bottomSheet<String?>(
  //     AddLinkBS(controller: insertLinkController),
  //     isScrollControlled: true,
  //     ignoreSafeArea: false,
  //     enableDrag: false,
  //   ).then((item) => {
  //     if (item != null)
  //       {
  //         showLink.value = item,
  //         validateLink(item),
  //       }
  //   });
  // }

  Future<void> validateLink(String str) async {
    islinkValid.value = await isLinkValid(str);
  }

  Future<bool> isLinkValid(String str) async {
    if (str.isEmpty || str.length > 2083 || str.indexOf('mailto:') == 0) {
      return false;
    }

    List<String> splitedList = str.split(' ');
    if (splitedList.length > 1) {
      return false;
    }

    if (!str.startsWith('http') || !str.startsWith('https')) {
      return false;
    }

    return true;
  }
}

class MediaResult {
  final File file;
  final FileType type;

  const MediaResult({
    required this.file,
    required this.type,
  });
}
