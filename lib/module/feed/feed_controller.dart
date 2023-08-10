import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/post/post_model.dart';
import 'package:parallel/_data/model/model/request_model.dart';
import 'package:parallel/_domain/repository/abstract/post_repository.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/util/mixin/subscribe_self_profile_mixin.dart';

class FeedController extends GetxController with SubscribeSelfProfileMixin {
  final PostRepository _postRepository = Get.find();
  final RxList<PostModel?> postListRx = RxList.empty();
  final RxInt currentPage = 0.obs;
  final RxBool isLast = false.obs;
  final RxBool isRefreshing = false.obs;

  final SearchRepository _searchRepository = Get.find();
  final RxList<RequestModel?> requestRx = RxList.empty();
  final TextEditingController searchController = TextEditingController();
  final RxString searchTextRx = ''.obs;
  Timer? searchOnStoppedTyping;

  FeedController() {
    getPostList();
  }

  void getPostList({bool reset = false}) async {
    if (reset) {
      currentPage.value = 0;
      isRefreshing.value = true;
    }
    postListRx.clear();
    _postRepository.getListPost(page: currentPage.value).then((ListModel<PostModel> postList) {
      if (postListRx.isNotEmpty && reset) {

        postListRx.clear();
      }
      postListRx.addAll(postList.data);
      isLast.value = postList.pagination.isLast;
      if (reset) {
        isRefreshing.value = false;
      }
    });
  }

  void loadMorePosts() async {
    if (!isRefreshing.value && isLast.value == false) {
      currentPage.value++;
      getPostList();
    }
  }

  void postSearchRequest() {
    _searchRepository
        .postRequestSearch(request: searchController.text)
        .then((value) => Get.showSuccessMessage(
              'Request sent successfully',
            ));
    clearSearchField();
  }

  void search(String searchText) {
    searchTextRx.value = searchText;
  }

  void clearSearchField() {
    if (searchTextRx.isNotEmpty) {
      searchController.clear();
      searchTextRx.value = '';
    }
  }
}
