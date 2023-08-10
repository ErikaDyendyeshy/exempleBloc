import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'update_tag_request.g.dart';

@JsonSerializable(createFactory: false)
class UpdateTagRequest extends ToJsonInterface {
  final String tag;

  UpdateTagRequest({
    required this.tag,
  });

  @override
  Map<String, dynamic> toJson() => _$UpdateTagRequestToJson(this);
}
