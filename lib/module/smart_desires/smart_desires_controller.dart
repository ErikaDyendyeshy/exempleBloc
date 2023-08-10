import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/list_request_model.dart';
import 'package:parallel/_data/model/model/request_model.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';
import 'package:parallel/_domain/wrapper/status_request_wrapper.dart';
import 'package:parallel/route/app_routes.dart';

class SmartDesiresController extends GetxController with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  final SearchRepository _searchRepository = Get.find();
  final RxList<RequestModel?> completedListRx = RxList.empty();
  final RxList<RequestModel?> processingListRx = RxList.empty();
  final RxList<RequestModel?> pausedListRx = RxList.empty();

  SmartDesiresController() {
    tabController = TabController(
      length: 3,
      vsync: this,
    );
    getProcessingListRequest();
    getPausedListRequest();
    getCompletedListRequest();
  }

  void getProcessingListRequest({bool reset = false}) async {
    processingListRx.clear();
    await _searchRepository
        .getListRequest(statusRequest: 'progress')
        .then((ListRequestModel listRequestModel) {
      if (processingListRx.isNotEmpty && reset) {
        processingListRx.clear();
      }
      processingListRx.addAll(listRequestModel.listRequest);
    });
  }

  void getPausedListRequest({bool reset = false}) async {
    pausedListRx.clear();

    await _searchRepository
        .getListRequest(statusRequest: 'paused')
        .then((ListRequestModel listRequestModel) {
      if (pausedListRx.isNotEmpty && reset) {
        pausedListRx.clear();
      }
      pausedListRx.addAll(listRequestModel.listRequest);
    });
  }

  void getCompletedListRequest({bool reset = false}) async {
    completedListRx.clear();

    await _searchRepository
        .getListRequest(statusRequest: 'done')
        .then((ListRequestModel listRequestModel) {
      if (completedListRx.isNotEmpty && reset) {
        completedListRx.clear();
      }
      completedListRx.addAll(listRequestModel.listRequest);
    });
  }

  void openSmartSearchScreen({String? status, String? requestId}) {
    Get.toNamed(RoutePaths.smartSearch,
        arguments: StatusRequestWrapper(
          statusRequest: status,
          requestId: requestId,
        ))?.then((result) {
      if (result == true) {
        getProcessingListRequest(reset: true);
        getPausedListRequest(reset: true);
        tabController.index = 1;
      }
    });
  }
}
