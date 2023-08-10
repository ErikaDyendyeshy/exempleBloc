import 'dart:convert';

import 'package:get/get.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/notification_data_source.dart';
import 'package:parallel/_data/model/model/notification/notification_model.dart';
import 'package:parallel/_data/model/request/notification_toggle_request.dart';
import 'package:parallel/util/http_extension.dart';

class NotificationDataSourceImpl extends NotificationDataSource {
  NotificationDataSourceImpl({
    required super.getConnect,
    required super.apiDataSource,
  });

  @override
  Future<List<NotificationModel>> getNotification() {
    return getConnect
        .getRequest(
      url: 'notifications/get_follows',
    )
        .then((Response response) {
      List<dynamic> responseBody = jsonDecode(response.bodyString!);
      return responseBody.map((json) => NotificationModel.fromJson(json)).toList();
    });
  }

  @override
  Future<void> updateNotifications({required bool enabled}) {
    return getConnect.postRequest(
      url: 'notifications/toggle',
      request: NotificationToggleRequest(
        enabled: enabled,
      ),
    );
  }
}
