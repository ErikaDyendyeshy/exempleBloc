import 'dart:convert';

import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/search_data_source.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/list_model/user_search_list_response.dart';
import 'package:parallel/_data/model/model/list_request_model.dart';
import 'package:parallel/_data/model/model/request_detail_model.dart';
import 'package:parallel/_data/model/model/request_toggle_pause_model.dart';
import 'package:parallel/_data/model/model/short_person_model_temp/short_person_model_temp.dart';
import 'package:parallel/_data/model/request/empty_request.dart';
import 'package:parallel/_data/model/request/search_request.dart';
import 'package:parallel/util/http_extension.dart';

class SearchDataSourceImpl extends SearchDataSource {
  SearchDataSourceImpl({
    required super.getConnect,
    required super.apiDataSource,
  });

  @override
  Future<void> postRequestSearch({required String request}) {
    return getConnect
        .postRequest(
          url: 'search/make_request',
          request: SearchRequest(
            request: request,
          ),
        )
        .then((value) => value.status.isOk);
  }

  @override
  Future<ListRequestModel> getListRequest({
    required String statusRequest,
  }) {
    final Map<String, dynamic> query = {};

    query['status'] = statusRequest;
    return getConnect
        .getRequest(
      url: 'search/my_requests',
      query: query,
    )
        .then((Response response) {
      return ListRequestModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
  }

  @override
  Future<RequestDetailModel> getRequestDetails({
    required String requestId,
  }) {
    return getConnect
        .getRequest(
      url: 'search/request/$requestId',
    )
        .then((Response response) {
      return RequestDetailModel.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
  }

  @override
  Future<void> toggleRequest({
    required String requestId,
    required bool pause,
  }) {
    return getConnect
        .postRequest(
          url: 'search/toggle_pause',
          request: RequestTogglePauseModel(
            requestId: requestId,
            pause: pause,
          ),
        )
        .then((value) => value.status.isOk);
  }

  @override
  Future<void> deleteRequest({required String requestId}) {
    return getConnect
        .deleteRequest(
          url: 'search/delete/$requestId',
          request: EmptyRequest(),
        )
        .then(
          (value) => value.status.isOk,
        );
  }

  @override
  Future<ListModel<ShortPersonModel>> getUserList({
    required String searchText,
    required int page,
  }) {
    final Map<String, dynamic> query = {};

    query['search'] = searchText;
    query['page'] = page.toString();

    return getConnect
        .getRequest(
      url: 'search/users_list',
      query: query,
    )
        .then((Response response) {
      return UserSearchListResponse.fromJson(
        jsonDecode(
          response.bodyString!,
        ),
      );
    });
  }
}
