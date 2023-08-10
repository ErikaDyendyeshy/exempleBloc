import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/auth_data_source.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/local_storage_data_source.dart';
import 'package:parallel/_data/data_source/api/impl/api_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/auth_data_source_impl.dart';
import 'package:parallel/_data/data_source/api/impl/sources/local_storage_data_source_impl.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/error_handler/error_handler_impl.dart';
import 'package:parallel/_domain/repository/abstract/repository.dart';
import 'package:parallel/_domain/repository/impl/repository_impl.dart';
import 'package:parallel/const.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(
      ApiDataSourceImpl(
        host: apiUrl,
        apiPrefix: 'api/',
      ),
      permanent: true,
    );

    Get.put<LocalStorageDataSource>(
      LocalStorageDataSourceImpl()..init(),
      permanent: true,
    );
    Get.put<GetConnect>(
      GetConnect(),
      permanent: true,
    );

    Get.put<AuthDataSource>(
      AuthDataSourceImpl(
        getConnect: Get.find<GetConnect>(),
        apiDataSource: Get.find<ApiDataSourceImpl>(),
      ),
      permanent: true,
    );

    Get.put<ErrorHandler>(
      ErrorHandlerImpl(
        Get.find<AuthDataSource>(),
        Get.find<LocalStorageDataSource>(),
      ),
      permanent: true,
    );

    Get.put<Repository>(
      RepositoryImpl(
        apiDataSource: Get.find<ApiDataSourceImpl>(),
        errorHandler: Get.find<ErrorHandler>(),
      ),
      permanent: true,
    );
  }
}
