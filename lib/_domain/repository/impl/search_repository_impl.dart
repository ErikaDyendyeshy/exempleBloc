import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_data/model/list_model.dart';
import 'package:parallel/_data/model/model/list_request_model.dart';
import 'package:parallel/_data/model/model/request_detail_model.dart';
import 'package:parallel/_data/model/model/short_person_model_temp/short_person_model_temp.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/error_handler/exception/base_exeption.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';

class SearchRepositoryImpl implements SearchRepository {
  final ApiDataSource _apiDataSource;
  final ErrorHandler _errorHandler;

  SearchRepositoryImpl(
    this._apiDataSource,
    this._errorHandler,
  );

  @override
  Future<void> postRequestSearch({
    required String request,
  }) {
    return _apiDataSource.searchDataSource
        .postRequestSearch(
      request: request,
    )
        .catchError(
      (exception) {
        _errorHandler.handleException(exception);
        throw exception is BaseException ? exception : exception as Exception;
      },
    );
  }

  @override
  Future<ListRequestModel> getListRequest({
    required String statusRequest,
  }) {
    return _apiDataSource.searchDataSource.getListRequest(
      statusRequest: statusRequest,
    );
  }

  @override
  Future<RequestDetailModel> getRequestDetails({
    required String requestId,
  }) {
    return _apiDataSource.searchDataSource.getRequestDetails(
      requestId: requestId,
    );
  }

  @override
  Future<void> toggleRequest({
    required String requestId,
    required bool pause,
  }) {
    return _apiDataSource.searchDataSource.toggleRequest(
      requestId: requestId,
      pause: pause,
    );
  }

  @override
  Future<void> deleteRequest({
    required String requestId,
  }) {
    return _apiDataSource.searchDataSource.deleteRequest(
      requestId: requestId,
    );
  }

  @override
  Future<ListModel<ShortPersonModel>> getUserList({
    required String searchText,
    required int page,
  }) {
    return _apiDataSource.searchDataSource.getUserList(
      searchText: searchText,
      page: page,
    );
  }
}
