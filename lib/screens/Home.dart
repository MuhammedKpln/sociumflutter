import 'package:auto_route/auto_route.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/repositories/fcm.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/storage/fcm.storage.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../utils/palette.dart';

class HomeScreenPage extends ConsumerStatefulWidget {
  const HomeScreenPage({Key? key}) : super(key: key);

  @override
  _HomeScreenPageState createState() => _HomeScreenPageState();
}

class _HomeScreenPageState extends ConsumerState<HomeScreenPage> {
  final _client = Supabase.instance.client;
  final FcmRepository _fcmRepository = FcmRepository();
  final FcmStorage _fcmStorage = FcmStorage();
  late GotrueSubscription stateChangeEvent;

  @override
  void initState() {
    super.initState();
    registerFcmToken();

    stateChangeEvent = _client.auth.onAuthStateChange((event, session) async {
      if (event == AuthChangeEvent.signedOut) {
        context.router.replaceAll([const OnboardScreenRoute()]);
      }
    });
  }

  Future<void> registerFcmToken() async {
    final fcmToken = await FirebaseMessaging.instance.getToken();
    final userNotifier = ref.read(userProvider);
    final userId = userNotifier.user?.id;
    final localFcmToken = await _fcmStorage.fcmToken;

    if (fcmToken != null) {
      if (localFcmToken == null) {
        await _fcmStorage.setFcmToken(fcmToken);
        await _fcmRepository.updateFcmToken(fcmToken: fcmToken, user: userId!);
      } else {
        if (fcmToken != localFcmToken) {
          await _fcmStorage.setFcmToken(fcmToken);
          await _fcmRepository.updateFcmToken(
              fcmToken: fcmToken, user: userId!);
        }
      }
    }
  }

  @override
  void dispose() {
    stateChangeEvent.data?.unsubscribe();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userNotifier = ref.watch(userProvider);
    final username = userNotifier.user?.username;

    return Scaffold(
        body: AutoTabsScaffold(
      routes: [
        const MatchRouter(),
        const ChatsRouter(),
        ProfileRoute(username: username ?? ""),
      ],
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
          backgroundColor: ColorPalette.surface,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.home), label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.messageCircle), label: "Chats"),
            BottomNavigationBarItem(
                icon: Icon(FeatherIcons.user), label: "Profile")
          ],
          showSelectedLabels: false,
          showUnselectedLabels: false,
        );
      },
    ));
  }
}
