import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'request_model.g.dart';

@JsonSerializable()
class RequestModel implements ToJsonInterface {
  final String id;
  final bool resolved;
  final String request;

  RequestModel({
    required this.id,
    required this.resolved,
    required this.request,
  });

  factory RequestModel.fromJson(Map<String, dynamic> json) => _$RequestModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RequestModelToJson(this);
}
