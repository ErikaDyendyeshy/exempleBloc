import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:parallel/_data/data_source/api/abstract/sources/local_storage_data_source.dart';
import 'package:parallel/_data/db_adapter/custom_info_model.dart';
import 'package:parallel/_data/db_adapter/profile_type_adapter.dart';
import 'package:parallel/_data/db_adapter/tag_adapter.dart';
import 'package:parallel/_data/db_adapter/user_adapter.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';

class LocalStorageDataSourceImpl extends LocalStorageDataSource {
  static const String _selfProfileBoxName = 'SelfProfile';

  late Box<ProfileModel> _profileBox;

  @override
  Future<void> init() async {
    await Hive.initFlutter();

    Hive.registerAdapter(ProfileAdapter());
    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(TagAdapter());
    Hive.registerAdapter(CustomInfoAdapter());
    _profileBox = await Hive.openBox<ProfileModel>(_selfProfileBoxName);
  }

  @override
  ValueListenable userListenable() {
    return _profileBox.listenable();
  }

  @override
  Future<void> saveUser(ProfileModel profile) async {
    await _profileBox.put(0, profile);
  }

  @override
  Future<void> clearLocalDataBase() async {
    await _profileBox.clear();
  }

  @override
  Future clearLocalDB() {
    return _profileBox.clear();
  }
}
