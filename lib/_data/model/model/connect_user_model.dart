import 'package:json_annotation/json_annotation.dart';

part 'connect_user_model.g.dart';

@JsonSerializable()
class ConnectUserModel {
  String id;
  String name;
  @JsonKey(name: 'data_created')
  DateTime? dateCreated;
  @JsonKey(name: 'avatar_url')
  String? avatarUrl;
  @JsonKey(
    name: 'is_subscribed_me_to_user',
    includeIfNull: false,
  )
  bool? isSubscribed;

  ConnectUserModel(
      {required this.id, required this.name, this.dateCreated, this.avatarUrl, this.isSubscribed});

  factory ConnectUserModel.fromJson(Map<String, dynamic> json) => _$ConnectUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$ConnectUserModelToJson(this);
}
