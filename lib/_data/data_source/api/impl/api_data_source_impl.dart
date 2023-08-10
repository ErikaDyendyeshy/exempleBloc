import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_data/data_source/api/impl/sources/auth_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/local_storage_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/notification_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/post_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/profile_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/search_data_source_impl.dart';

class ApiDataSourceImpl extends ApiDataSource {
  final GetConnect _getConnect = GetConnect();
  static const String _tokenKey = 'Authorization';

  ApiDataSourceImpl({
    required super.host,
    required super.apiPrefix,
  }) {
    _getConnect.baseUrl = apiHost;

    _getConnect.httpClient.addRequestModifier<Object?>((request) async {
      String? accessToken = await authDataSource.getAuthToken();
      if (accessToken != null && accessToken.isNotEmpty) {
        request.headers[_tokenKey] = 'Bearer $accessToken';
      }
      return request;
    });
    _getConnect.httpClient.addAuthenticator<Object?>((request) async {
      final String refreshToken = await authDataSource.getRefreshToken() ?? '';
      if (refreshToken.isNotEmpty) {
        final String accessToken =
            await authDataSource.updateAccessToken(refreshToken: refreshToken);
        request.headers[_tokenKey] = 'Bearer $accessToken';
      }
      return request;
    });
    _initSources();
  }

  void _initSources() {
    authDataSource = AuthDataSourceImpl(
      getConnect: _getConnect,
      apiDataSource: this,
    );
    profileDataSource = ProfileDataSourceImpl(
      getConnect: _getConnect,
      apiDataSource: this,
    );
    searchDataSource = SearchDataSourceImpl(
      getConnect: _getConnect,
      apiDataSource: this,
    );
    postDataSource = PostDataSourceImpl(
      getConnect: _getConnect,
      apiDataSource: this,
    );
    notificationDataSource = NotificationDataSourceImpl(
      getConnect: _getConnect,
      apiDataSource: this,
    );

    localStorage = LocalStorageDataSourceImpl();
  }
}
