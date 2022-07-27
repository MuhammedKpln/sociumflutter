import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage.dart';

saveLogin(AuthStateModel user) async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  if (box.containsKey(StorageKeys.AccessToken)) {
    await box.delete(StorageKeys.AccessToken);
  }

  if (box.containsKey(StorageKeys.RefreshToken)) {
    await box.delete(StorageKeys.RefreshToken);
  }

  if (box.containsKey(StorageKeys.User)) {
    await box.delete(StorageKeys.User);
  }
  await box.putAll({
    StorageKeys.AccessToken: user.accessToken,
    StorageKeys.RefreshToken: user.refreshToken,
    StorageKeys.User: json.encode(user.user)
  });
}

Future<bool> isLoggedIn() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  if (box.containsKey(StorageKeys.AccessToken)) {
    return true;
  }

  return false;
}

getAccessToken() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  return await box.get(StorageKeys.AccessToken);
}

getRefreshToken() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  return await box.get(StorageKeys.RefreshToken);
}

getUser() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  if (box.containsKey(StorageKeys.User)) {
    final user = await box.get(StorageKeys.User);

    if (user != null) {
      return User.fromJson(json.decode(user));
    }
  }
}

deleteUser() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  await box.clear();
}
