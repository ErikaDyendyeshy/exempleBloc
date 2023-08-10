import 'package:flutter/foundation.dart';
import 'package:parallel/_data/model/model/profile/profile_model.dart';

abstract class LocalStorageDataSource {
  Future init();

  Future saveUser(ProfileModel profile);

  Future clearLocalDataBase();

  ValueListenable userListenable();

  Future clearLocalDB();
}
