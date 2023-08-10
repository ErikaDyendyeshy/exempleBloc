import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/gallery_model.dart';
import 'package:parallel/_data/model/model/post/my_post_model.dart';
import 'package:parallel/_data/model/model/relations_count_model.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/_domain/wrapper/post_detail_wrapper.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';
import 'package:parallel/widget/__.dart';

class ProfileController extends GetxController
    with GetSingleTickerProviderStateMixin, SubscribeSelfProfileMixin {
  final ProfileRepository _profileRepository = Get.find();
  final RxList<MyPostModel> postListRx = RxList.empty();
  final RxList<GalleryModel> galleryListRx = RxList.empty();

  final RxBool isLoading = false.obs;
  final Rx<RelationsCountModel?> relationsCountRx = Rx(null);
  final RxInt currentPage = 0.obs;
  final RxBool isLast = false.obs;

  late TabController tabController;

  ProfileController() {
    tabController = TabController(
      length: 2,
      vsync: this,
    );
  }

  @override
  void onReady() async {
    super.onReady();
    isLoading.value = true;
    await getMyGallery();
    await getMyPost();
    await getRelationsCount();
    isLoading.value = false;
  }

  Future<void> getRelationsCount() async {
    isLoading.value = true;
    await _profileRepository
        .getRelationsCount(profileId: selfProfile.value!.user.id)
        .then((RelationsCountModel relationsCount) {
      relationsCountRx.value = relationsCount;
      isLoading.value = false;
    });
    isLoading.value = false;
  }

  Future<void> getMyPost() async {
    postListRx.clear();
    List<MyPostModel> list = await _profileRepository.getMyPost();

    list.sort((a, b) => b.dateCreated.compareTo(
        a.dateCreated)); //TODO ask back-end to properly sort my posts

    postListRx.addAll(list);
  }

  Future<void> getMyGallery() async {
    galleryListRx.clear();
    await _profileRepository
        .getGalleryList(
      userId: selfProfile.value!.user.id,
      page: currentPage.value,
    )
        .then(
      (ListModel<GalleryModel> galleryList) {
        galleryListRx.addAll(galleryList.data);
        isLast.value = galleryList.pagination.isLast;
      },
    );
  }

  void loadMoreGalleryPages() async {
    if (isLast.value == false) {
      currentPage.value++;
      getMyGallery();
    }
  }

  String getVideoIdFromUrl(String url) {
    RegExp regExp = RegExp(r"(?<=youtu\.be\/|v\=)([^#\&\?]*).*");
    Match? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }

  void goToCreatePost() {
    Get.toNamed(RoutePaths.createPost)!.whenComplete(() {
      getMyPost();
      getMyGallery();
    });
  }

  void editProfileScreen() {
    Get.toNamed(RoutePaths.editProfile);
  }

  void openShowMoreAboutMe() {
    Get.bottomSheet(
      isScrollControlled: true,
      PBottomSheetWidget(
        child: PMoreAboutUserWidget(
          aboutUser: selfProfile.value!.user.aboutMe,
          customInfo: selfProfile.value!.customInfo,
          tags: selfProfile.value!.tags,
        ),
      ),
    );
  }

  void openDetailPage(String postId) {
    Get.toNamed(
      RoutePaths.postDetail,
      arguments: PostDetailWrapper(postId: postId, isMyPost: true),
    );
  }

  void openConnectionList() async {
    await Get.toNamed(RoutePaths.connectionList)!.then(
      (result) {
        if (result == true) {
          getRelationsCount();
        }
      },
    );
  }
}
