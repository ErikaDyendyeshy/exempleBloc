import 'package:parallel/_data/model/model/person_model.dart';
import 'package:parallel/_data/model/model/request_model.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
import 'package:json_annotation/json_annotation.dart';
part 'request_detail_model.g.dart';

@JsonSerializable()
class RequestDetailModel extends ToJsonInterface {
  final RequestModel request;
  final List<PersonModel> results;

  RequestDetailModel({
    required this.request,
    required this.results,
  });

  factory RequestDetailModel.fromJson(Map<String, dynamic> json) => _$RequestDetailModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$RequestDetailModelToJson(this);
}