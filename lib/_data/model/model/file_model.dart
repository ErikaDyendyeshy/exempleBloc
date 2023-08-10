import 'package:json_annotation/json_annotation.dart';
import 'package:parallel/_data/model/model/to_json_interface.dart';

part 'file_model.g.dart';

@JsonSerializable()
class FileModel extends ToJsonInterface {
  @JsonKey(name: 'url')
  final String file;

  FileModel(
    this.file,
  );

  factory FileModel.fromJson(Map<String, dynamic> json) =>
      _$FileModelFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$FileModelToJson(this);
}
