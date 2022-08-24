import 'package:auto_route/auto_route.dart';
import 'package:scflutter/screens/ChatNew.dart';
import 'package:scflutter/screens/Home.dart';
import 'package:scflutter/screens/Login.dart';
import 'package:scflutter/screens/Match.dart';
import 'package:scflutter/screens/Onboard.dart';
import 'package:scflutter/screens/Register/StepFour.dart';
import 'package:scflutter/screens/Register/StepOne.dart';
import 'package:scflutter/screens/Register/StepThree.dart';
import 'package:scflutter/screens/Register/StepTwo.dart';

import '../screens/Chat/InCallManager.dart';
import '../screens/Chats.dart';
import '../screens/Profile.dart';
import '../screens/ProfileSettings/BirthdaySettings.dart';
import '../screens/ProfileSettings/BlockIncomingCalls.dart';
import '../screens/ProfileSettings/ProfileSettings.dart';
import '../screens/ProfileSettings/bio_settings.dart';

@MaterialAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: OnboardScreenPage, initial: true),
    AutoRoute(page: LoginScreenPage),
    AutoRoute(page: RegisterScreenStepOnePage),
    AutoRoute(page: RegisterScreenStepTwoPage),
    AutoRoute(page: RegisterStepThreeScreenPage),
    AutoRoute(page: RegisterScreenStepFourPage),
    // AutoRoute(page: CallComingPage, fullscreenDialog: true),
    AutoRoute(page: HomeScreenPage, children: [
      AutoRoute(page: MatchScreenPage),
      AutoRoute(page: ProfilePage),
      AutoRoute(page: ChatsScreenPage),
    ]),
    // AutoRoute(
    //   page: ChatScreenPage,
    // ),
    AutoRoute(
      page: ChatNew,
    ),
    // AutoRoute(page: MatchFound, fullscreenDialog: true),
    AutoRoute(page: ProfileSettingsScreenPage),
    AutoRoute(page: BioSettingsPage),
    AutoRoute(page: BirthdaySettingsPage),
    AutoRoute(page: BlockIncomingCallsScreenPage),
    AutoRoute(page: InCallManagerScreenPage, fullscreenDialog: true),
    // AutoRoute(page: TestScreen),
  ],
)
class $AppRouter {}
