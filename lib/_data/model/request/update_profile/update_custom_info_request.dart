import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'update_custom_info_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateCustomInfoRequest extends ToJsonInterface {
  final String? title;
  final String? info;

  UpdateCustomInfoRequest({
    this.title,
    this.info,
  });

  @override
  Map<String, dynamic> toJson() => _$UpdateCustomInfoRequestToJson(this);
}
