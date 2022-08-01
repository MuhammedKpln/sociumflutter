import 'package:auto_route/auto_route.dart';
import 'package:scflutter/components/Match/MatchFound.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/screens/Chat.dart';
import 'package:scflutter/screens/Chat/InCallManager.dart';
import 'package:scflutter/screens/Chats.dart';
import 'package:scflutter/screens/Home.dart';
import 'package:scflutter/screens/Login.dart';
import 'package:scflutter/screens/Match.dart';
import 'package:scflutter/screens/Onboard.dart';
import 'package:scflutter/screens/Profile.dart';
import 'package:scflutter/screens/ProfileSettings/BirthdaySettings.dart';
import 'package:scflutter/screens/ProfileSettings/BlockIncomingCalls.dart';
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
    AutoRoute(page: OnboardScreenPage, initial: true),
    AutoRoute(page: LoginScreenPage),
    AutoRoute(page: RegisterScreenStepOnePage),
    AutoRoute(page: RegisterScreenStepTwoPage),
    AutoRoute(page: RegisterStepThreeScreenPage),
    AutoRoute(page: RegisterScreenStepFourPage),
    AutoRoute(page: CallComingPage, fullscreenDialog: true),
    AutoRoute(page: HomeScreenPage, guards: [
      AuthGuard
    ], children: [
      AutoRoute(page: MatchScreenPage),
      AutoRoute(page: ProfilePage),
      AutoRoute(page: ChatsScreenPage),
    ]),
    AutoRoute(
      page: ChatScreenPage,
    ),
    AutoRoute(page: MatchFound, fullscreenDialog: true),
    AutoRoute(page: ProfileSettingsScreenPage),
    AutoRoute(page: BioSettingsPage),
    AutoRoute(page: BirthdaySettingsPage),
    AutoRoute(page: BlockIncomingCallsScreenPage),
    AutoRoute(page: InCallManagerScreenPage, fullscreenDialog: true),
    AutoRoute(page: TestScreen),
  ],
)
class $AppRouter {}
