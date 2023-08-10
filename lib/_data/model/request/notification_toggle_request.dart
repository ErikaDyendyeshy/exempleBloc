import 'package:json_annotation/json_annotation.dart';
part 'notification_toggle_request.g.dart';


@JsonSerializable()
class NotificationToggleRequest {
  final bool enabled;

  NotificationToggleRequest({
    required this.enabled,
  });

  factory NotificationToggleRequest.fromJson(Map<String, dynamic> json ) => _$NotificationToggleRequestFromJson(json);

  Map<String, dynamic> toJson() => _$NotificationToggleRequestToJson(this);
}
