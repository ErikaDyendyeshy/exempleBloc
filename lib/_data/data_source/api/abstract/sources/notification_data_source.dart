import 'package:parallel/_data/data_source/api/abstract/data_source.dart';
import 'package:parallel/_data/model/model/notification/notification_model.dart';

abstract class NotificationDataSource extends DataSource {
  NotificationDataSource({
    required super.getConnect,
    required super.apiDataSource,
  });

  Future<List<NotificationModel>> getNotification();

  Future<void> updateNotifications({
    required bool enabled,
  });
}
