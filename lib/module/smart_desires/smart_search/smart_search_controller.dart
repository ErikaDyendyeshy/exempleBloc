import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:parallel/_data/model/model/request_detail_model.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';
import 'package:parallel/_domain/wrapper/status_request_wrapper.dart';
import 'package:parallel/route/app_routes.dart';
import 'package:parallel/util/extensions/snackbar.dart';
import 'package:parallel/widget/__.dart';

class SmartSearchController extends GetxController {
  final SearchRepository _searchRepository = Get.find();
  final TextEditingController searchController = TextEditingController();
  final RxString searchTextRx = ''.obs;
  final RxString statusRequest = ''.obs;
  final RxString requestIdRx = ''.obs;
  final RxBool startAnimation = false.obs;
  final Rx<RequestDetailModel?> requestDetailRx = Rx(null);
  final RxBool isLoading = false.obs;

  final RxBool pausedRequestRx = false.obs;

  SmartSearchController() {
    if (Get.arguments is StatusRequestWrapper) {
      final StatusRequestWrapper arg = Get.arguments as StatusRequestWrapper;
      statusRequest.value = arg.statusRequest!;
      if (statusRequest.value == 'paused') {
        pausedRequestRx.value = true;
      }
      if (arg.requestId != null) {
        requestIdRx.value = arg.requestId!;
      }
    }
    if (requestIdRx.value.isNotEmpty) {
      getRequestDetails();
    }
  }

  void getBack() {
    Get.back();
  }

  void getRequestDetails() {
    _searchRepository
        .getRequestDetails(requestId: requestIdRx.value)
        .then((RequestDetailModel requestDetail) {
      requestDetailRx.value = requestDetail;
    });
  }

  void postSearchRequest() {
    isLoading.value = true;
    _searchRepository.postRequestSearch(request: searchController.text).then((value) {
      Get.back(result: true);
      Get.showSuccessMessage(
        'Request sent successfully',
      );
    });
    clearSearchField();
    isLoading.value = false;
  }

  void clearSearchField() {
    if (searchTextRx.isNotEmpty) {
      searchController.clear();
      searchTextRx.value = '';
    }
  }

  void checkTextSearch(String text) {
    searchTextRx.value = text;
  }

  void togglePauseRequest({required String requestId}) {
    _searchRepository
        .toggleRequest(
      requestId: requestId,
      pause: pausedRequestRx.value == true ? false : true,
    )
        .then((value) {
      if (pausedRequestRx.value == true) {
        pausedRequestRx.value = false;
      } else {
        pausedRequestRx.value = true;
      }
    });
  }

  void openOptionMenu() {
    Get.bottomSheet(
      PBottomSheetWidget(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              PButtonWidget(
                colorBorder: Get.theme.colorScheme.error,
                textStyle: Get.theme.textTheme.displayMedium!.copyWith(
                  color: Get.theme.colorScheme.error,
                ),
                text: 'txt_delete'.tr.capitalizeFirst!,
                colorTrascparent: true,
                onPressed: () => confirmDeletion(),
              ),
              const SizedBox(height: 16),
              PButtonWidget(
                text: 'txt_cancel'.tr.capitalizeFirst!,
                onPressed: () => Get.back(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void confirmDeletion() {
    Get.bottomSheet(PBottomSheetWidget(
      title: '${'txt_delete'.tr.capitalizeFirst!}?',
      description: 'txt_if_you_delete_this_search'.tr,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            PButtonWidget(
              text: 'txt_delete'.tr.capitalizeFirst!,
              onPressed: () => deleteRequest(),
            ),
            const SizedBox(height: 16),
            PButtonWidget(
              text: 'txt_cancel'.tr.capitalizeFirst!,
              colorTrascparent: true,
              onPressed: () => Get.close(3),
            )
          ],
        ),
      ),
    ));
  }

  void deleteRequest() {
    _searchRepository
        .deleteRequest(
      requestId: requestIdRx.value,
    )
        .then((value) {
      Get.close(2);
      Get.back(result: true);
    });
  }

  void openProfile({required String personId}) {
    Get.toNamed(RoutePaths.otherProfile, arguments: personId);
  }

  bool get isFormValid {
    return searchTextRx.value.length >= 50;
  }
}
