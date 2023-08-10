import 'package:hive_flutter/hive_flutter.dart';
import 'package:parallel/_data/model/model/profile/custom_info_model.dart';

class CustomInfoAdapter extends TypeAdapter<CustomInfoModel> {
  @override
  int get typeId => 3;

  @override
  CustomInfoModel read(BinaryReader reader) {
    final id = reader.readString();
    final title = reader.readString();
    final info = reader.readString();

    return CustomInfoModel(
      id: id,
      title: title,
      info: info,
    );
  }

  @override
  void write(BinaryWriter writer, CustomInfoModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.title);
    writer.writeString(obj.info);
  }
}
