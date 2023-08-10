import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';
part 'logout_model.g.dart';

@JsonSerializable()
class LogoutModel extends ToJsonInterface {
  final String refresh;

  LogoutModel({
    required this.refresh,
  });

  factory LogoutModel.fromJson(Map<String, dynamic> json) => _$LogoutModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$LogoutModelToJson(this);
}
