// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i10;
import 'package:flutter/material.dart' as _i11;
import 'package:scflutter/guards/auth.guard.dart' as _i12;
import 'package:scflutter/screens/Home.dart' as _i7;
import 'package:scflutter/screens/Login.dart' as _i2;
import 'package:scflutter/screens/Match.dart' as _i8;
import 'package:scflutter/screens/Onboard.dart' as _i1;
import 'package:scflutter/screens/Profile.dart' as _i9;
import 'package:scflutter/screens/Register/StepFour.dart' as _i6;
import 'package:scflutter/screens/Register/StepOne.dart' as _i3;
import 'package:scflutter/screens/Register/StepThree.dart' as _i5;
import 'package:scflutter/screens/Register/StepTwo.dart' as _i4;

class AppRouter extends _i10.RootStackRouter {
  AppRouter(
      {_i11.GlobalKey<_i11.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i12.AuthGuard authGuard;

  @override
  final Map<String, _i10.PageFactory> pagesMap = {
    OnboardScreen.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.OnboardScreen());
    },
    LoginScreen.name: (routeData) {
      final args = routeData.argsAs<LoginScreenArgs>(
          orElse: () => const LoginScreenArgs());
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: _i2.LoginScreen(key: args.key));
    },
    RegisterScreenStepOne.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepOneArgs>(
          orElse: () => const RegisterScreenStepOneArgs());
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.RegisterScreenStepOne(key: args.key));
    },
    RegisterScreenStepTwo.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.RegisterScreenStepTwo());
    },
    RegisterStepThreeScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterStepThreeScreenArgs>();
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.RegisterStepThreeScreen(
              key: args.key, allowedChatMethods: args.allowedChatMethods));
    },
    RegisterScreenStepFour.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepFourArgs>();
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.RegisterScreenStepFour(
              key: args.key, email: args.email, username: args.username));
    },
    HomeScreen.name: (routeData) {
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i7.HomeScreen());
    },
    MatchScreen.name: (routeData) {
      final args = routeData.argsAs<MatchScreenArgs>(
          orElse: () => const MatchScreenArgs());
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: _i8.MatchScreen(key: args.key));
    },
    ProfileScreen.name: (routeData) {
      final args = routeData.argsAs<ProfileScreenArgs>(
          orElse: () => const ProfileScreenArgs());
      return _i10.AdaptivePage<dynamic>(
          routeData: routeData, child: _i9.ProfileScreen(key: args.key));
    }
  };

  @override
  List<_i10.RouteConfig> get routes => [
        _i10.RouteConfig(OnboardScreen.name, path: '/'),
        _i10.RouteConfig(LoginScreen.name, path: '/login-screen'),
        _i10.RouteConfig(RegisterScreenStepOne.name,
            path: '/register-screen-step-one'),
        _i10.RouteConfig(RegisterScreenStepTwo.name,
            path: '/register-screen-step-two'),
        _i10.RouteConfig(RegisterStepThreeScreen.name,
            path: '/register-step-three-screen'),
        _i10.RouteConfig(RegisterScreenStepFour.name,
            path: '/register-screen-step-four'),
        _i10.RouteConfig(HomeScreen.name, path: '/home-screen', guards: [
          authGuard
        ], children: [
          _i10.RouteConfig(MatchScreen.name,
              path: 'match-screen', parent: HomeScreen.name),
          _i10.RouteConfig(ProfileScreen.name,
              path: 'profile-screen', parent: HomeScreen.name)
        ])
      ];
}

/// generated route for
/// [_i1.OnboardScreen]
class OnboardScreen extends _i10.PageRouteInfo<void> {
  const OnboardScreen() : super(OnboardScreen.name, path: '/');

  static const String name = 'OnboardScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i10.PageRouteInfo<LoginScreenArgs> {
  LoginScreen({_i11.Key? key})
      : super(LoginScreen.name,
            path: '/login-screen', args: LoginScreenArgs(key: key));

  static const String name = 'LoginScreen';
}

class LoginScreenArgs {
  const LoginScreenArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'LoginScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i3.RegisterScreenStepOne]
class RegisterScreenStepOne
    extends _i10.PageRouteInfo<RegisterScreenStepOneArgs> {
  RegisterScreenStepOne({_i11.Key? key})
      : super(RegisterScreenStepOne.name,
            path: '/register-screen-step-one',
            args: RegisterScreenStepOneArgs(key: key));

  static const String name = 'RegisterScreenStepOne';
}

class RegisterScreenStepOneArgs {
  const RegisterScreenStepOneArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'RegisterScreenStepOneArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.RegisterScreenStepTwo]
class RegisterScreenStepTwo extends _i10.PageRouteInfo<void> {
  const RegisterScreenStepTwo()
      : super(RegisterScreenStepTwo.name, path: '/register-screen-step-two');

  static const String name = 'RegisterScreenStepTwo';
}

/// generated route for
/// [_i5.RegisterStepThreeScreen]
class RegisterStepThreeScreen
    extends _i10.PageRouteInfo<RegisterStepThreeScreenArgs> {
  RegisterStepThreeScreen({_i11.Key? key, required dynamic allowedChatMethods})
      : super(RegisterStepThreeScreen.name,
            path: '/register-step-three-screen',
            args: RegisterStepThreeScreenArgs(
                key: key, allowedChatMethods: allowedChatMethods));

  static const String name = 'RegisterStepThreeScreen';
}

class RegisterStepThreeScreenArgs {
  const RegisterStepThreeScreenArgs(
      {this.key, required this.allowedChatMethods});

  final _i11.Key? key;

  final dynamic allowedChatMethods;

  @override
  String toString() {
    return 'RegisterStepThreeScreenArgs{key: $key, allowedChatMethods: $allowedChatMethods}';
  }
}

/// generated route for
/// [_i6.RegisterScreenStepFour]
class RegisterScreenStepFour
    extends _i10.PageRouteInfo<RegisterScreenStepFourArgs> {
  RegisterScreenStepFour(
      {_i11.Key? key, required dynamic email, required dynamic username})
      : super(RegisterScreenStepFour.name,
            path: '/register-screen-step-four',
            args: RegisterScreenStepFourArgs(
                key: key, email: email, username: username));

  static const String name = 'RegisterScreenStepFour';
}

class RegisterScreenStepFourArgs {
  const RegisterScreenStepFourArgs(
      {this.key, required this.email, required this.username});

  final _i11.Key? key;

  final dynamic email;

  final dynamic username;

  @override
  String toString() {
    return 'RegisterScreenStepFourArgs{key: $key, email: $email, username: $username}';
  }
}

/// generated route for
/// [_i7.HomeScreen]
class HomeScreen extends _i10.PageRouteInfo<void> {
  const HomeScreen({List<_i10.PageRouteInfo>? children})
      : super(HomeScreen.name, path: '/home-screen', initialChildren: children);

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i8.MatchScreen]
class MatchScreen extends _i10.PageRouteInfo<MatchScreenArgs> {
  MatchScreen({_i11.Key? key})
      : super(MatchScreen.name,
            path: 'match-screen', args: MatchScreenArgs(key: key));

  static const String name = 'MatchScreen';
}

class MatchScreenArgs {
  const MatchScreenArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'MatchScreenArgs{key: $key}';
  }
}

/// generated route for
/// [_i9.ProfileScreen]
class ProfileScreen extends _i10.PageRouteInfo<ProfileScreenArgs> {
  ProfileScreen({_i11.Key? key})
      : super(ProfileScreen.name,
            path: 'profile-screen', args: ProfileScreenArgs(key: key));

  static const String name = 'ProfileScreen';
}

class ProfileScreenArgs {
  const ProfileScreenArgs({this.key});

  final _i11.Key? key;

  @override
  String toString() {
    return 'ProfileScreenArgs{key: $key}';
  }
}
