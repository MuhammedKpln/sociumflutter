// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i18;
import 'package:flutter/material.dart' as _i19;

import '../components/Match/MatchFound.dart' as _i10;
import '../guards/auth.guard.dart' as _i20;
import '../models/message.dart' as _i23;
import '../models/user_model.dart' as _i22;
import '../screens/Chat.dart' as _i9;
import '../screens/Chat/CallComing.dart' as _i7;
import '../screens/Chats.dart' as _i17;
import '../screens/Home.dart' as _i8;
import '../screens/Login.dart' as _i2;
import '../screens/Match.dart' as _i15;
import '../screens/Onboard.dart' as _i1;
import '../screens/Profile.dart' as _i16;
import '../screens/ProfileSettings/bio_settings.dart' as _i12;
import '../screens/ProfileSettings/BirthdaySettings.dart' as _i13;
import '../screens/ProfileSettings/ProfileSettings.dart' as _i11;
import '../screens/Register/StepFour.dart' as _i6;
import '../screens/Register/StepOne.dart' as _i3;
import '../screens/Register/StepThree.dart' as _i5;
import '../screens/Register/StepTwo.dart' as _i4;
import '../screens/testscreen.dart' as _i14;
import '../services/websocket.events.dart' as _i21;

class AppRouter extends _i18.RootStackRouter {
  AppRouter(
      {_i19.GlobalKey<_i19.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i20.AuthGuard authGuard;

  @override
  final Map<String, _i18.PageFactory> pagesMap = {
    OnboardScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.OnboardScreen());
    },
    LoginScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenStepOne.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepOneArgs>(
          orElse: () => const RegisterScreenStepOneArgs());
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i3.RegisterScreenStepOne(key: args.key));
    },
    RegisterScreenStepTwo.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterScreenStepTwo());
    },
    RegisterStepThreeScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterStepThreeScreenArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.RegisterStepThreeScreen(
              key: args.key, allowedChatMethods: args.allowedChatMethods));
    },
    RegisterScreenStepFour.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepFourArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.RegisterScreenStepFour(
              key: args.key, email: args.email, username: args.username));
    },
    CallComing.name: (routeData) {
      final args = routeData.argsAs<CallComingArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.CallComing(
              key: args.key,
              username: args.username,
              onAcceptCall: args.onAcceptCall,
              onRejectCall: args.onRejectCall),
          fullscreenDialog: true);
    },
    HomeScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.HomeScreen());
    },
    Chat.name: (routeData) {
      final args = routeData.argsAs<ChatArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.Chat(
              key: args.key,
              comingFromMatchedPage: args.comingFromMatchedPage,
              socketService: args.socketService,
              connectedUser: args.connectedUser,
              room: args.room,
              userUUID: args.userUUID));
    },
    MatchFound.name: (routeData) {
      final args = routeData.argsAs<MatchFoundArgs>();
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.MatchFound(
              key: args.key,
              user: args.user,
              room: args.room,
              userUUID: args.userUUID,
              socketService: args.socketService),
          fullscreenDialog: true);
    },
    ProfileSettings.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProfileSettings());
    },
    BioSettingsRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.BioSettingsPage());
    },
    BirthdaySettingsRoute.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.BirthdaySettingsPage());
    },
    TestScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i14.TestScreen());
    },
    MatchScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.MatchScreen());
    },
    ProfileScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.ProfileScreen());
    },
    ChatsScreen.name: (routeData) {
      return _i18.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.ChatsScreen());
    }
  };

  @override
  List<_i18.RouteConfig> get routes => [
        _i18.RouteConfig(OnboardScreen.name, path: '/'),
        _i18.RouteConfig(LoginScreen.name, path: '/login-screen'),
        _i18.RouteConfig(RegisterScreenStepOne.name,
            path: '/register-screen-step-one'),
        _i18.RouteConfig(RegisterScreenStepTwo.name,
            path: '/register-screen-step-two'),
        _i18.RouteConfig(RegisterStepThreeScreen.name,
            path: '/register-step-three-screen'),
        _i18.RouteConfig(RegisterScreenStepFour.name,
            path: '/register-screen-step-four'),
        _i18.RouteConfig(CallComing.name, path: '/call-coming'),
        _i18.RouteConfig(HomeScreen.name, path: '/home-screen', guards: [
          authGuard
        ], children: [
          _i18.RouteConfig(MatchScreen.name,
              path: 'match-screen', parent: HomeScreen.name),
          _i18.RouteConfig(ProfileScreen.name,
              path: 'profile-screen', parent: HomeScreen.name),
          _i18.RouteConfig(ChatsScreen.name,
              path: 'chats-screen', parent: HomeScreen.name)
        ]),
        _i18.RouteConfig(Chat.name, path: '/Chat'),
        _i18.RouteConfig(MatchFound.name, path: '/match-found'),
        _i18.RouteConfig(ProfileSettings.name, path: '/profile-settings'),
        _i18.RouteConfig(BioSettingsRoute.name, path: '/bio-settings-page'),
        _i18.RouteConfig(BirthdaySettingsRoute.name,
            path: '/birthday-settings-page'),
        _i18.RouteConfig(TestScreen.name, path: '/test-screen')
      ];
}

/// generated route for
/// [_i1.OnboardScreen]
class OnboardScreen extends _i18.PageRouteInfo<void> {
  const OnboardScreen() : super(OnboardScreen.name, path: '/');

  static const String name = 'OnboardScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i18.PageRouteInfo<void> {
  const LoginScreen() : super(LoginScreen.name, path: '/login-screen');

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i3.RegisterScreenStepOne]
class RegisterScreenStepOne
    extends _i18.PageRouteInfo<RegisterScreenStepOneArgs> {
  RegisterScreenStepOne({_i19.Key? key})
      : super(RegisterScreenStepOne.name,
            path: '/register-screen-step-one',
            args: RegisterScreenStepOneArgs(key: key));

  static const String name = 'RegisterScreenStepOne';
}

class RegisterScreenStepOneArgs {
  const RegisterScreenStepOneArgs({this.key});

  final _i19.Key? key;

  @override
  String toString() {
    return 'RegisterScreenStepOneArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.RegisterScreenStepTwo]
class RegisterScreenStepTwo extends _i18.PageRouteInfo<void> {
  const RegisterScreenStepTwo()
      : super(RegisterScreenStepTwo.name, path: '/register-screen-step-two');

  static const String name = 'RegisterScreenStepTwo';
}

/// generated route for
/// [_i5.RegisterStepThreeScreen]
class RegisterStepThreeScreen
    extends _i18.PageRouteInfo<RegisterStepThreeScreenArgs> {
  RegisterStepThreeScreen({_i19.Key? key, required dynamic allowedChatMethods})
      : super(RegisterStepThreeScreen.name,
            path: '/register-step-three-screen',
            args: RegisterStepThreeScreenArgs(
                key: key, allowedChatMethods: allowedChatMethods));

  static const String name = 'RegisterStepThreeScreen';
}

class RegisterStepThreeScreenArgs {
  const RegisterStepThreeScreenArgs(
      {this.key, required this.allowedChatMethods});

  final _i19.Key? key;

  final dynamic allowedChatMethods;

  @override
  String toString() {
    return 'RegisterStepThreeScreenArgs{key: $key, allowedChatMethods: $allowedChatMethods}';
  }
}

/// generated route for
/// [_i6.RegisterScreenStepFour]
class RegisterScreenStepFour
    extends _i18.PageRouteInfo<RegisterScreenStepFourArgs> {
  RegisterScreenStepFour(
      {_i19.Key? key, required dynamic email, required dynamic username})
      : super(RegisterScreenStepFour.name,
            path: '/register-screen-step-four',
            args: RegisterScreenStepFourArgs(
                key: key, email: email, username: username));

  static const String name = 'RegisterScreenStepFour';
}

class RegisterScreenStepFourArgs {
  const RegisterScreenStepFourArgs(
      {this.key, required this.email, required this.username});

  final _i19.Key? key;

  final dynamic email;

  final dynamic username;

  @override
  String toString() {
    return 'RegisterScreenStepFourArgs{key: $key, email: $email, username: $username}';
  }
}

/// generated route for
/// [_i7.CallComing]
class CallComing extends _i18.PageRouteInfo<CallComingArgs> {
  CallComing(
      {_i19.Key? key,
      required String username,
      required Function onAcceptCall,
      required Function onRejectCall})
      : super(CallComing.name,
            path: '/call-coming',
            args: CallComingArgs(
                key: key,
                username: username,
                onAcceptCall: onAcceptCall,
                onRejectCall: onRejectCall));

  static const String name = 'CallComing';
}

class CallComingArgs {
  const CallComingArgs(
      {this.key,
      required this.username,
      required this.onAcceptCall,
      required this.onRejectCall});

  final _i19.Key? key;

  final String username;

  final Function onAcceptCall;

  final Function onRejectCall;

  @override
  String toString() {
    return 'CallComingArgs{key: $key, username: $username, onAcceptCall: $onAcceptCall, onRejectCall: $onRejectCall}';
  }
}

/// generated route for
/// [_i8.HomeScreen]
class HomeScreen extends _i18.PageRouteInfo<void> {
  const HomeScreen({List<_i18.PageRouteInfo>? children})
      : super(HomeScreen.name, path: '/home-screen', initialChildren: children);

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i9.Chat]
class Chat extends _i18.PageRouteInfo<ChatArgs> {
  Chat(
      {_i19.Key? key,
      required bool comingFromMatchedPage,
      required _i21.SocketService socketService,
      _i22.User? connectedUser,
      _i23.Room? room,
      String? userUUID})
      : super(Chat.name,
            path: '/Chat',
            args: ChatArgs(
                key: key,
                comingFromMatchedPage: comingFromMatchedPage,
                socketService: socketService,
                connectedUser: connectedUser,
                room: room,
                userUUID: userUUID));

  static const String name = 'Chat';
}

class ChatArgs {
  const ChatArgs(
      {this.key,
      required this.comingFromMatchedPage,
      required this.socketService,
      this.connectedUser,
      this.room,
      this.userUUID});

  final _i19.Key? key;

  final bool comingFromMatchedPage;

  final _i21.SocketService socketService;

  final _i22.User? connectedUser;

  final _i23.Room? room;

  final String? userUUID;

  @override
  String toString() {
    return 'ChatArgs{key: $key, comingFromMatchedPage: $comingFromMatchedPage, socketService: $socketService, connectedUser: $connectedUser, room: $room, userUUID: $userUUID}';
  }
}

/// generated route for
/// [_i10.MatchFound]
class MatchFound extends _i18.PageRouteInfo<MatchFoundArgs> {
  MatchFound(
      {_i19.Key? key,
      required _i22.User user,
      required _i23.Room room,
      required String userUUID,
      required _i21.SocketService socketService})
      : super(MatchFound.name,
            path: '/match-found',
            args: MatchFoundArgs(
                key: key,
                user: user,
                room: room,
                userUUID: userUUID,
                socketService: socketService));

  static const String name = 'MatchFound';
}

class MatchFoundArgs {
  const MatchFoundArgs(
      {this.key,
      required this.user,
      required this.room,
      required this.userUUID,
      required this.socketService});

  final _i19.Key? key;

  final _i22.User user;

  final _i23.Room room;

  final String userUUID;

  final _i21.SocketService socketService;

  @override
  String toString() {
    return 'MatchFoundArgs{key: $key, user: $user, room: $room, userUUID: $userUUID, socketService: $socketService}';
  }
}

/// generated route for
/// [_i11.ProfileSettings]
class ProfileSettings extends _i18.PageRouteInfo<void> {
  const ProfileSettings()
      : super(ProfileSettings.name, path: '/profile-settings');

  static const String name = 'ProfileSettings';
}

/// generated route for
/// [_i12.BioSettingsPage]
class BioSettingsRoute extends _i18.PageRouteInfo<void> {
  const BioSettingsRoute()
      : super(BioSettingsRoute.name, path: '/bio-settings-page');

  static const String name = 'BioSettingsRoute';
}

/// generated route for
/// [_i13.BirthdaySettingsPage]
class BirthdaySettingsRoute extends _i18.PageRouteInfo<void> {
  const BirthdaySettingsRoute()
      : super(BirthdaySettingsRoute.name, path: '/birthday-settings-page');

  static const String name = 'BirthdaySettingsRoute';
}

/// generated route for
/// [_i14.TestScreen]
class TestScreen extends _i18.PageRouteInfo<void> {
  const TestScreen() : super(TestScreen.name, path: '/test-screen');

  static const String name = 'TestScreen';
}

/// generated route for
/// [_i15.MatchScreen]
class MatchScreen extends _i18.PageRouteInfo<void> {
  const MatchScreen() : super(MatchScreen.name, path: 'match-screen');

  static const String name = 'MatchScreen';
}

/// generated route for
/// [_i16.ProfileScreen]
class ProfileScreen extends _i18.PageRouteInfo<void> {
  const ProfileScreen() : super(ProfileScreen.name, path: 'profile-screen');

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i17.ChatsScreen]
class ChatsScreen extends _i18.PageRouteInfo<void> {
  const ChatsScreen() : super(ChatsScreen.name, path: 'chats-screen');

  static const String name = 'ChatsScreen';
}
