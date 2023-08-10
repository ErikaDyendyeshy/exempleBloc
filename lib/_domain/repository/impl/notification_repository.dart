import 'package:parallel/_data/data_source/api/abstract/api_data_source.dart';
import 'package:parallel/_data/model/model/notification/notification_model.dart';
import 'package:parallel/_domain/error_handler/error_handler.dart';
import 'package:parallel/_domain/repository/abstract/notification_repository.dart';

class NotificationRepositoryImpl implements NotificationRepository {
  final ApiDataSource _apiDataSource;
  final ErrorHandler _errorHandler;

  NotificationRepositoryImpl(this._apiDataSource,
      this._errorHandler,);

  @override
  Future<List<NotificationModel>> getFollows() {
    return _apiDataSource.notificationDataSource.getNotification();
  }

  @override
  Future<void> updateNotifications({required bool enabled}) {
    return _apiDataSource.notificationDataSource.updateNotifications(
        enabled: enabled,
    );
  }
}
