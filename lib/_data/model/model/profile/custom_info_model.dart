import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'custom_info_model.g.dart';

@JsonSerializable()
class CustomInfoModel extends ToJsonInterface {
  final String id;
  final String title;
  final String info;

  CustomInfoModel({
    required this.id,
    required this.title,
    required this.info,
  });

  factory CustomInfoModel.fromJson(Map<String, dynamic> json) => _$CustomInfoModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$CustomInfoModelToJson(this);
}
