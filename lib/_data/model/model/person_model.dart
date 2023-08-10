import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
part 'person_model.g.dart';


@JsonSerializable()
class PersonModel extends ToJsonInterface {
  final String id;
  final String name;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'about_me', )
  final String aboutMe;
  final int following;
  final int followers;

  PersonModel({
    required this.id,
    required this.name,
    required this.avatarUrl,
    required this.aboutMe,
    required this.followers,
    required this.following,
  });

  factory PersonModel.fromJson(Map<String, dynamic> json) => _$PersonModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$PersonModelToJson(this);
}
