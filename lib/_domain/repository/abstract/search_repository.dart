import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/list_request_model.dart';
import 'package:parallel/_data/model/model/request_detail_model.dart';
import 'package:parallel/_data/model/model/short_person_model_temp/short_person_model_temp.dart';

abstract class SearchRepository {
  Future<void> postRequestSearch({
    required String request,
  });

  Future<ListRequestModel> getListRequest({
    required String statusRequest,
  });

  Future<RequestDetailModel> getRequestDetails({
    required String requestId,
  });

  Future<void> toggleRequest({
    required String requestId,
    required bool pause,
  });

  Future<void> deleteRequest({
    required String requestId,
  });

  Future<ListModel<ShortPersonModel>> getUserList({
    required String searchText,
    required int page,
  });
}
