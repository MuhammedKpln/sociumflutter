import 'dart:convert';

import 'package:hive/hive.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage.dart';

Future<void> saveLogin(AuthStateModel user) async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  if (box.containsKey(StorageKeys.AccessToken)) {
    await box.delete(StorageKeys.AccessToken);
  }

  if (box.containsKey(StorageKeys.User)) {
    await box.delete(StorageKeys.User);
  }
  await box.putAll({
    StorageKeys.AccessToken: user.accessToken,
    StorageKeys.User: json.encode(user.user)
  });
}

getAccessToken() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  return await box.get(StorageKeys.AccessToken);
}

getUser() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  if (box.containsKey(StorageKeys.User)) {
    final user = await box.get(StorageKeys.User);

    if (user != null) {
      return Login$Mutation$Login$User.fromJson(json.decode(user));
    }
  }
}

deleteUser() async {
  final box = await Hive.openLazyBox(StorageBoxes.Auth);

  await box.clear();
}
