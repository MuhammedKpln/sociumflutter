import 'package:auto_route/auto_route.dart';
import 'package:scflutter/screens/Match/Communities.dart';
import 'package:scflutter/screens/ChatNew.dart';
import 'package:scflutter/screens/Home.dart';
import 'package:scflutter/screens/Login.dart';
import 'package:scflutter/screens/Match.dart';
import 'package:scflutter/screens/Onboard.dart';
import 'package:scflutter/screens/Profile/Followers.dart';
import 'package:scflutter/screens/Register/StepFour.dart';
import 'package:scflutter/screens/Register/StepOne.dart';
import 'package:scflutter/screens/Register/StepThree.dart';
import 'package:scflutter/screens/Register/StepTwo.dart';
import 'package:scflutter/screens/RoomDetails.dart';
import 'package:scflutter/screens/Rooms.dart';
import 'package:scflutter/screens/Router/ChatsRouter.dart';
import 'package:scflutter/screens/Router/MatchRouter.dart';
import 'package:scflutter/screens/Settings.dart';
import '../screens/Chat/CallComing.dart';
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
    AutoRoute(page: CallComingPage, fullscreenDialog: true),
    AutoRoute(page: HomeScreenPage, children: [
      AutoRoute(page: MatchRouter, children: [
        AutoRoute(page: MatchScreenPage, initial: true),
        AutoRoute(page: CommunitiesTabPage),
      ]),
      AutoRoute(
        page: ProfilePage,
      ),
      AutoRoute(
          page: ChatsRouter,
          children: [AutoRoute(page: ChatsScreenPage, initial: true)],
          name: "ChatsRouter"),
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
    AutoRoute(page: FollowersPage, fullscreenDialog: true),
    AutoRoute(page: RoomDetailsPage, fullscreenDialog: false),
    AutoRoute(
        page: ProfilePage,
        fullscreenDialog: true,
        name: "ProfilePageAsDialogRoute"),
    AutoRoute(
      page: SettingsPage,
      fullscreenDialog: true,
    ),
    AutoRoute(
      page: RoomsPage,
      fullscreenDialog: true,
    ),
    // AutoRoute(page: TestScreen),
  ],
)
class $AppRouter {}
