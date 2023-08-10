import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/repository/abstract/auth_repository.dart';
import 'package:parallel/_domain/repository/abstract/notification_repository.dart';
import 'package:parallel/_domain/repository/abstract/post_repository.dart';
import 'package:parallel/_domain/repository/abstract/profile_repository.dart';
import 'package:parallel/_domain/repository/abstract/repository.dart';
import 'package:parallel/_domain/repository/abstract/search_repository.dart';
import 'package:parallel/_domain/repository/impl/auth_repositoy_impl.dart';
import 'package:parallel/_domain/repository/impl/notification_repository.dart';
import 'package:parallel/_domain/repository/impl/post_repository_impl.dart';
import 'package:parallel/_domain/repository/impl/profile_repository_impl.dart';
import 'package:parallel/_domain/repository/impl/search_repository_impl.dart';

class RepositoryImpl extends Repository {
  RepositoryImpl({
    required ApiDataSource apiDataSource,
    required ErrorHandler errorHandler,
  }) : super(
          apiDataSource: apiDataSource,
          errorHandler: errorHandler,
        ) {
    Get.put<AuthRepository>(
      AuthRepositoryImpl(
        apiDataSource,
        errorHandler,
      ),
      permanent: true,
    );
    Get.put<ProfileRepository>(
      ProfileRepositoryImpl(
        apiDataSource,
        Get.find(),
        errorHandler,
      ),
      permanent: true,
    );
    Get.put<SearchRepository>(
      SearchRepositoryImpl(
        apiDataSource,
        errorHandler,
      ),
      permanent: true,
    );
    Get.put<PostRepository>(
      PostRepositoryImpl(
        apiDataSource,
        errorHandler,
      ),
      permanent: true,
    );
    Get.put<NotificationRepository>(
      NotificationRepositoryImpl(
        apiDataSource,
        errorHandler,
      ),
      permanent: true,
    );
    authRepository = Get.find<AuthRepository>();
    profileRepository = Get.find<ProfileRepository>();
  }
}
