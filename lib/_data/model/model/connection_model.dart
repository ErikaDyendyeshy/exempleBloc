import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/connect_user_model.dart';

part 'connection_model.g.dart';

@JsonSerializable()
class ConnectionModel {
  String id;
  @JsonKey(name: 'follower', includeIfNull: false)
  ConnectUserModel? follower;
  @JsonKey(name: 'following', includeIfNull: false)
  ConnectUserModel? following;

  ConnectionModel({
    required this.id,
    this.follower,
    this.following,
  });

  factory ConnectionModel.fromJson(Map<String, dynamic> json) => _$ConnectionModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectionModelToJson(this);

}
