import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'update_user_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateUserRequest extends ToJsonInterface {
  final String id;
  final String name;
  @JsonKey(name: 'birth_date')
  final String? birthDate;
  final String? country;
  @JsonKey(name: 'about_me')
  final String? aboutMe;
  @JsonKey(name: 'avatar_url')
  final String? avatarUri;

  UpdateUserRequest({
    required this.id,
    required this.name,
    this.country,
    this.birthDate,
    this.aboutMe,
    this.avatarUri,
  });

  @override
  Map<String, dynamic> toJson() => _$UpdateUserRequestToJson(this);
}
