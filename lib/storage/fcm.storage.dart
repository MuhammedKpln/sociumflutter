import 'package:hive_flutter/hive_flutter.dart';
import 'package:scflutter/storage.dart';

class FcmStorage {
  Future<String?> get fcmToken async {
    final box = await Hive.openLazyBox(StorageBoxes.Fcm);

    return await box.get(StorageKeys.FcmToken) as String?;
  }

  setFcmToken(String fcmToken) async {
    final box = await Hive.openLazyBox(StorageBoxes.Fcm);

    if (box.containsKey(StorageKeys.FcmToken)) {
      await box.delete(StorageKeys.FcmToken);
    }

    await box.put(StorageKeys.FcmToken, fcmToken);
  }
}
