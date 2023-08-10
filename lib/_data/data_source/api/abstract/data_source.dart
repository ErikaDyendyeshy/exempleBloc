import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/util/http_extension.dart';

abstract class DataSource {
  late final GetConnect getConnect;
  late final ApiDataSource apiDataSource;

  DataSource({
    required this.getConnect,
    required this.apiDataSource,
  });

  String? setHostToUrl(String? url) {
    if (url == null) {
      return null;
    }

    return '${getConnect.protocolInfo.origin}/$url';
  }
}
