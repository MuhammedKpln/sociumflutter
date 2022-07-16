import 'package:auto_route/auto_route.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/screens/Home.dart';
import 'package:scflutter/screens/Login.dart';
import 'package:scflutter/screens/Match.dart';
import 'package:scflutter/screens/Onboard.dart';
import 'package:scflutter/screens/Profile.dart';
import 'package:scflutter/screens/Register/StepFour.dart';
import 'package:scflutter/screens/Register/StepOne.dart';
import 'package:scflutter/screens/Register/StepThree.dart';
import 'package:scflutter/screens/Register/StepTwo.dart';

@AdaptiveAutoRouter(
  replaceInRouteName: 'Page,Route',
  routes: <AutoRoute>[
    AutoRoute(page: OnboardScreen, initial: true),
    AutoRoute(page: LoginScreen),
    AutoRoute(page: RegisterScreenStepOne),
    AutoRoute(page: RegisterScreenStepTwo),
    AutoRoute(page: RegisterStepThreeScreen),
    AutoRoute(page: RegisterScreenStepFour),
    AutoRoute(page: HomeScreen, guards: [
      AuthGuard
    ], children: [
      AutoRoute(page: MatchScreen),
      AutoRoute(page: ProfileScreen),
    ]),
  ],
)
class $AppRouter {}
