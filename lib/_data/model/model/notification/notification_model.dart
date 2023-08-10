import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/notification/follower_short_model.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'notification_model.g.dart';

@JsonSerializable()
class NotificationModel extends ToJsonInterface {
  @JsonKey(name: 'follow')
  final FollowerShortModel follower;
  @JsonKey(name: 'notification_type')
  final int type;
  NotificationModel({
    required this.follower,
    required this.type,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      _$NotificationModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$NotificationModelToJson(this);
}
