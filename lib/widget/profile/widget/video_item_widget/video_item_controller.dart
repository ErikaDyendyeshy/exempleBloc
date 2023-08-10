import 'dart:async';

import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class VideoItemController extends GetxController {
  late VideoPlayerController videoPlayerController;

  final RxBool isMediaInizialized = false.obs;
  final RxBool isVideoPlaying = false.obs;
  final RxBool isMuted = false.obs;
  final RxBool isControlPanelVisible = true.obs;
  final RxBool isVideoLoadingInProgress = false.obs;
  final RxString position = RxString('0:00:00');

  final double soundVolume = 4.0;

  Timer? timer;

  void handleTapOnPlayButton() {
    if (isVideoPlaying.value) {
      pauseVideo();
    } else {
      playVideo();
      if (!isControlPanelVisible.value) {
        isControlPanelVisible.value = true;
        hideControlPannel();
      }
    }
  }

  void handleTapOnVideo() {
    if (!isControlPanelVisible.value || !isVideoPlaying.value) {
      isControlPanelVisible.value = true;
      hideControlPannel();
    } else {
      isControlPanelVisible.value = !isControlPanelVisible.value;
    }
  }

  void hideControlPannel() {
    if (!isControlPanelVisible.value) {
      isControlPanelVisible.value = true;
      Timer(const Duration(seconds: 5), () {
        isControlPanelVisible.value = false;
      });
    }
  }

  void initializePlayer(media) {
    videoPlayerController = VideoPlayerController.networkUrl(
      Uri.parse(
        media.mediaUrl,
      ),
    );

    videoPlayerController.initialize().then((value) {
      isMediaInizialized.value = true;
      videoPlayerController.setLooping(true);
    }).onError((error, stackTrace) {
      isMediaInizialized.value = false;
      videoPlayerController.dispose();
    });
  }

  void playVideo() {
    if (!isMediaInizialized.value) {
      return;
    }
    if (isMediaInizialized.value && !videoPlayerController.value.isPlaying) {
      isVideoPlaying.value = true;
      isControlPanelVisible.value = false;

      videoPlayerController.play();
      startTimer();
    }
  }

  void startTimer() {
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      if (!videoPlayerController.value.isPlaying) {
        t.cancel();
      } else {
        position.value =
            videoPlayerController.value.position.toString().split('.').first;
      }
    });
  }

  void pauseVideo() {
    if (!isMediaInizialized.value) {
      return;
    }
    if (timer != null) {
      timer!.cancel();
      timer = null;
    }
    isVideoLoadingInProgress.value = false;
    isVideoPlaying.value = false;
    videoPlayerController.pause();
  }

  void toggleMute() {
    if (isMuted.value) {
      videoPlayerController.setVolume(soundVolume);
    } else {
      videoPlayerController.setVolume(0.0);
    }
    isMuted.toggle();
  }

  String getVideoIdFromUrl(String url) {
    RegExp regExp = RegExp(r"(?<=youtu\.be\/|v\=)([^#\&\?]*).*");
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  @override
  void onClose() {
    if (isMediaInizialized.value) {
      videoPlayerController.dispose();
    }
    super.onClose();
  }
}
