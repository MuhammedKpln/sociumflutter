import 'package:auto_route/auto_route.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scflutter/storage.dart';
import 'package:scflutter/utils/router.gr.dart';

class AuthGuard extends AutoRouteGuard {
  @override
  void onNavigation(NavigationResolver resolver, StackRouter router) async {
    final box = Hive.openLazyBox(StorageBoxes.Auth);

    box.whenComplete(() {
      box.asStream().listen((event) {
        if (event.containsKey(StorageKeys.AccessToken)) {
          resolver.next();
        } else {
          router.push(const LoginScreen());
        }
      });
    });
  }
}
