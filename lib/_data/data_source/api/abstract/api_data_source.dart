import 'package:parallel/_data/data_source/api/abstract/sources/auth_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/local_storage_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/notification_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/post_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/profile_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/search_data_source.dart';

abstract class ApiDataSource {
  late final String _host;
  late final String _apiPrefix;

  late final AuthDataSource authDataSource;
  late final LocalStorageDataSource localStorage;
  late final ProfileDataSource profileDataSource;
  late final SearchDataSource searchDataSource;
  late final PostDataSource postDataSource;
  late final NotificationDataSource notificationDataSource;

  String get host => _host;

  String get apiHost => _host + _apiPrefix;

  ApiDataSource({
    required String host,
    required String apiPrefix,
  })  : _host = host,
        _apiPrefix = apiPrefix;
}
