import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
import 'package:parallel/_data/model/request/update_profile/update_custom_info_request.dart';
import 'package:parallel/_data/model/request/update_profile/update_tag_request.dart';
import 'package:parallel/_data/model/request/update_profile/update_user_request.dart';

part 'update_profile_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateProfileRequest extends ToJsonInterface {
  @JsonKey(name: 'user')
  final UpdateUserRequest updateUserRequest;
  @JsonKey(name: 'tags')
  final List<UpdateTagRequest> updateTagRequest;
  @JsonKey(name: 'custom_info')
  final List<UpdateCustomInfoRequest> updateCustomInfoRequest;

  UpdateProfileRequest({
    required this.updateUserRequest,
    required this.updateTagRequest,
    required this.updateCustomInfoRequest,
  });

  @override
  Map<String, dynamic> toJson() => _$UpdateProfileRequestToJson(this);
}
