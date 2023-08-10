import 'package:hive_flutter/hive_flutter.dart';
import 'package:parallel/_data/model/model/profile/tag_model.dart';

class TagAdapter extends TypeAdapter<TagModel> {
  @override
  int get typeId => 2;

  @override
  TagModel read(BinaryReader reader) {
    final id = reader.readString();
    final tag = reader.readString();

    return TagModel(
      id: id,
      tag: tag,
    );
  }

  @override
  void write(BinaryWriter writer, TagModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.tag);
  }
}
