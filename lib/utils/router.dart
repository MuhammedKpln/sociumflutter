import 'package:auto_route/auto_route.dart';
import 'package:scflutter/components/Match/MatchFound.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/screens/Chat.dart';
import 'package:scflutter/screens/Chats.dart';
import 'package:scflutter/screens/Home.dart';
import 'package:scflutter/screens/Login.dart';
import 'package:scflutter/screens/Match.dart';
import 'package:scflutter/screens/Onboard.dart';
import 'package:scflutter/screens/Profile.dart';
import 'package:scflutter/screens/ProfileSettings/ProfileSettings.dart';
import 'package:scflutter/screens/ProfileSettings/bio_settings.dart';
import 'package:scflutter/screens/Register/StepFour.dart';
import 'package:scflutter/screens/Register/StepOne.dart';
import 'package:scflutter/screens/Register/StepThree.dart';
import 'package:scflutter/screens/Register/StepTwo.dart';
import 'package:scflutter/screens/testscreen.dart';

import '../screens/Chat/CallComing.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: OnboardScreen, initial: true),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: RegisterScreenStepOne),
    AutoRoute(page: RegisterScreenStepTwo),
    AutoRoute(page: RegisterStepThreeScreen),
    AutoRoute(page: RegisterScreenStepFour),
    AutoRoute(page: CallComing, fullscreenDialog: true),
    AutoRoute(page: HomeScreen, guards: [
      AuthGuard
    ], children: [
      AutoRoute(page: MatchScreen),
      AutoRoute(page: ProfileScreen),
      AutoRoute(page: ChatsScreen),
    ]),
    AutoRoute(
      page: Chat,
    ),
    AutoRoute(page: MatchFound, fullscreenDialog: true),
    AutoRoute(page: ProfileSettings),
    AutoRoute(page: BioSettingsPage),
    AutoRoute(page: TestScreen),
  ],
)
class $AppRouter {}
