import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parallel/_data/model/model/profile/custom_info_model.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';
import 'package:parallel/_data/model/model/profile/tag_model.dart';
import 'package:parallel/_data/model/model/profile/user_model.dart';

class ProfileAdapter extends TypeAdapter<ProfileModel> {
  @override
  int get typeId => 0;

  @override
  ProfileModel read(BinaryReader reader) {
    final Map<dynamic, dynamic> fields = reader.readMap();

    return ProfileModel(
      user: fields['user'] as UserModel,
      tags: List<TagModel>.from(fields['tags'] as List<dynamic>),
      customInfo: List<CustomInfoModel>.from(fields['custom_info'] as List<dynamic>),
    );
  }

  @override
  void write(BinaryWriter writer, ProfileModel obj) {
    writer.writeMap({
      'user': obj.user,
      'tags': obj.tags,
      'custom_info': obj.customInfo,
    });
  }
}
