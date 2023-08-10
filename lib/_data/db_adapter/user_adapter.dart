import 'package:hive/hive.dart';
import 'package:parallel/_data/model/model/profile/user_model.dart';

class UserAdapter extends TypeAdapter<UserModel> {
  @override
  int get typeId => 1;

  @override
  UserModel read(BinaryReader reader) {
    final id = reader.readString();
    final name = reader.readString();
    final birthDate = reader.readString();
    final country = reader.readString();
    final aboutMe = reader.readString();
    final avatarUrl = reader.readString();
    final email = reader.readString();

    return UserModel(
      id: id,
      name: name,
      birthDate: birthDate,
      country: country,
      aboutMe: aboutMe,
      avatarUrl: avatarUrl,
      email: email,
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.id);
    writer.writeString(obj.name);
    writer.writeString(obj.birthDate);
    writer.writeString(obj.country ?? '');
    writer.writeString(obj.aboutMe);
    writer.writeString(obj.avatarUrl);
    writer.writeString(obj.email ?? '');
  }
}
