import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'request_toggle_pause_model.g.dart';



@JsonSerializable()
class RequestTogglePauseModel extends ToJsonInterface {
  @JsonKey(name: 'request_id')
  final String requestId;
  final bool pause;

  RequestTogglePauseModel({
    required this.requestId,
    required this.pause
});
  factory RequestTogglePauseModel.fromJson(Map<String, dynamic> json) => _$RequestTogglePauseModelFromJson(json);


  @override
  Map<String, dynamic> toJson() => _$RequestTogglePauseModelToJson(this);
}