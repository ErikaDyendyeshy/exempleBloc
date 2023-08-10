import 'package:parallel/_data/model/model/notification/notification_model.dart';

abstract class NotificationRepository {
  Future<List<NotificationModel>> getFollows();

  Future<void> updateNotifications({
    required bool enabled,
  });
}
