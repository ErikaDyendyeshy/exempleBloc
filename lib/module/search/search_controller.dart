import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/short_person_model_temp/short_person_model_temp.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';
import 'package:parallel/route/app_routes.dart';

class SearchController extends GetxController {
  final SearchRepository _searchRepository = Get.find();

  TextEditingController searchController = TextEditingController();
  final RxBool isLast = false.obs;
  final RxBool isLoading = false.obs;

  RxList<ShortPersonModel> userListRx = RxList.empty();
  final RxInt currentPageRx = 0.obs;

  final RxString searchTextRx = ''.obs;

  Timer? searchOnStoppedTyping;

  void clearSearchField() {
    if (searchTextRx.isNotEmpty) {
      searchController.clear();
      searchTextRx.value = '';
    }
  }

  void search(String searchText) {
    Duration duration = const Duration(milliseconds: 800);

    if (searchOnStoppedTyping != null) {
      searchOnStoppedTyping!.cancel();
    }
    searchTextRx.value = searchText;
    searchOnStoppedTyping = Timer(duration, () {
      getUserList(search: searchText);
    });
  }

  void loadMoreUsers() async {
    if (isLast.value == false) {
      currentPageRx.value++;
      getUserList(search: searchTextRx.value);
    }
  }

  void getUserList({required String search}) async {
    isLoading.value = true;
    if (searchTextRx.isNotEmpty) {
      await _searchRepository
          .getUserList(page: currentPageRx.value, searchText: search)
          .then(
        (ListModel<ShortPersonModel> userList) {
          userListRx.replaceRange(0, userListRx.length, userList.data);
          isLast.value = userList.pagination.isLast;
        },
      );
    } else {
      userListRx.clear();
    }
    isLoading.value = false;
  }

  void openProfile({required String personId}) {
    Get.toNamed(RoutePaths.otherProfile, arguments: personId);
  }

  void getBack() {
    Get.back();
  }

}
