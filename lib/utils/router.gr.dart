// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i14;
import 'package:flutter/material.dart' as _i15;
import 'package:scflutter/components/Match/MatchFound.dart' as _i10;
import 'package:scflutter/guards/auth.guard.dart' as _i16;
import 'package:scflutter/models/message.dart' as _i19;
import 'package:scflutter/models/user_model.dart' as _i18;
import 'package:scflutter/screens/Chat.dart' as _i9;
import 'package:scflutter/screens/Chat/CallComing.dart' as _i7;
import 'package:scflutter/screens/Chats.dart' as _i13;
import 'package:scflutter/screens/Home.dart' as _i8;
import 'package:scflutter/screens/Login.dart' as _i2;
import 'package:scflutter/screens/Match.dart' as _i11;
import 'package:scflutter/screens/Onboard.dart' as _i1;
import 'package:scflutter/screens/Profile.dart' as _i12;
import 'package:scflutter/screens/Register/StepFour.dart' as _i6;
import 'package:scflutter/screens/Register/StepOne.dart' as _i3;
import 'package:scflutter/screens/Register/StepThree.dart' as _i5;
import 'package:scflutter/screens/Register/StepTwo.dart' as _i4;
import 'package:scflutter/services/websocket.events.dart' as _i17;

class AppRouter extends _i14.RootStackRouter {
  AppRouter(
      {_i15.GlobalKey<_i15.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i16.AuthGuard authGuard;

  @override
  final Map<String, _i14.PageFactory> pagesMap = {
    OnboardScreen.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i1.OnboardScreen());
    },
    LoginScreen.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i2.LoginScreen());
    },
    RegisterScreenStepOne.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepOneArgs>(
          orElse: () => const RegisterScreenStepOneArgs());
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i3.RegisterScreenStepOne(key: args.key));
    },
    RegisterScreenStepTwo.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i4.RegisterScreenStepTwo());
    },
    RegisterStepThreeScreen.name: (routeData) {
      final args = routeData.argsAs<RegisterStepThreeScreenArgs>();
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i5.RegisterStepThreeScreen(
              key: args.key, allowedChatMethods: args.allowedChatMethods));
    },
    RegisterScreenStepFour.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepFourArgs>();
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i6.RegisterScreenStepFour(
              key: args.key, email: args.email, username: args.username));
    },
    CallComing.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData,
          child: const _i7.CallComing(),
          fullscreenDialog: true);
    },
    HomeScreen.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i8.HomeScreen());
    },
    Chat.name: (routeData) {
      final args = routeData.argsAs<ChatArgs>();
      return _i14.AdaptivePage<dynamic>(
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
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData,
          child: _i10.MatchFound(
              key: args.key,
              user: args.user,
              room: args.room,
              userUUID: args.userUUID,
              socketService: args.socketService),
          fullscreenDialog: true);
    },
    MatchScreen.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i11.MatchScreen());
    },
    ProfileScreen.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i12.ProfileScreen());
    },
    ChatsScreen.name: (routeData) {
      return _i14.AdaptivePage<dynamic>(
          routeData: routeData, child: const _i13.ChatsScreen());
    }
  };

  @override
  List<_i14.RouteConfig> get routes => [
        _i14.RouteConfig(OnboardScreen.name, path: '/'),
        _i14.RouteConfig(LoginScreen.name, path: '/login-screen'),
        _i14.RouteConfig(RegisterScreenStepOne.name,
            path: '/register-screen-step-one'),
        _i14.RouteConfig(RegisterScreenStepTwo.name,
            path: '/register-screen-step-two'),
        _i14.RouteConfig(RegisterStepThreeScreen.name,
            path: '/register-step-three-screen'),
        _i14.RouteConfig(RegisterScreenStepFour.name,
            path: '/register-screen-step-four'),
        _i14.RouteConfig(CallComing.name, path: '/call-coming'),
        _i14.RouteConfig(HomeScreen.name, path: '/home-screen', guards: [
          authGuard
        ], children: [
          _i14.RouteConfig(MatchScreen.name,
              path: 'match-screen', parent: HomeScreen.name),
          _i14.RouteConfig(ProfileScreen.name,
              path: 'profile-screen', parent: HomeScreen.name),
          _i14.RouteConfig(ChatsScreen.name,
              path: 'chats-screen', parent: HomeScreen.name)
        ]),
        _i14.RouteConfig(Chat.name, path: '/Chat'),
        _i14.RouteConfig(MatchFound.name, path: '/match-found')
      ];
}

/// generated route for
/// [_i1.OnboardScreen]
class OnboardScreen extends _i14.PageRouteInfo<void> {
  const OnboardScreen() : super(OnboardScreen.name, path: '/');

  static const String name = 'OnboardScreen';
}

/// generated route for
/// [_i2.LoginScreen]
class LoginScreen extends _i14.PageRouteInfo<void> {
  const LoginScreen() : super(LoginScreen.name, path: '/login-screen');

  static const String name = 'LoginScreen';
}

/// generated route for
/// [_i3.RegisterScreenStepOne]
class RegisterScreenStepOne
    extends _i14.PageRouteInfo<RegisterScreenStepOneArgs> {
  RegisterScreenStepOne({_i15.Key? key})
      : super(RegisterScreenStepOne.name,
            path: '/register-screen-step-one',
            args: RegisterScreenStepOneArgs(key: key));

  static const String name = 'RegisterScreenStepOne';
}

class RegisterScreenStepOneArgs {
  const RegisterScreenStepOneArgs({this.key});

  final _i15.Key? key;

  @override
  String toString() {
    return 'RegisterScreenStepOneArgs{key: $key}';
  }
}

/// generated route for
/// [_i4.RegisterScreenStepTwo]
class RegisterScreenStepTwo extends _i14.PageRouteInfo<void> {
  const RegisterScreenStepTwo()
      : super(RegisterScreenStepTwo.name, path: '/register-screen-step-two');

  static const String name = 'RegisterScreenStepTwo';
}

/// generated route for
/// [_i5.RegisterStepThreeScreen]
class RegisterStepThreeScreen
    extends _i14.PageRouteInfo<RegisterStepThreeScreenArgs> {
  RegisterStepThreeScreen({_i15.Key? key, required dynamic allowedChatMethods})
      : super(RegisterStepThreeScreen.name,
            path: '/register-step-three-screen',
            args: RegisterStepThreeScreenArgs(
                key: key, allowedChatMethods: allowedChatMethods));

  static const String name = 'RegisterStepThreeScreen';
}

class RegisterStepThreeScreenArgs {
  const RegisterStepThreeScreenArgs(
      {this.key, required this.allowedChatMethods});

  final _i15.Key? key;

  final dynamic allowedChatMethods;

  @override
  String toString() {
    return 'RegisterStepThreeScreenArgs{key: $key, allowedChatMethods: $allowedChatMethods}';
  }
}

/// generated route for
/// [_i6.RegisterScreenStepFour]
class RegisterScreenStepFour
    extends _i14.PageRouteInfo<RegisterScreenStepFourArgs> {
  RegisterScreenStepFour(
      {_i15.Key? key, required dynamic email, required dynamic username})
      : super(RegisterScreenStepFour.name,
            path: '/register-screen-step-four',
            args: RegisterScreenStepFourArgs(
                key: key, email: email, username: username));

  static const String name = 'RegisterScreenStepFour';
}

class RegisterScreenStepFourArgs {
  const RegisterScreenStepFourArgs(
      {this.key, required this.email, required this.username});

  final _i15.Key? key;

  final dynamic email;

  final dynamic username;

  @override
  String toString() {
    return 'RegisterScreenStepFourArgs{key: $key, email: $email, username: $username}';
  }
}

/// generated route for
/// [_i7.CallComing]
class CallComing extends _i14.PageRouteInfo<void> {
  const CallComing() : super(CallComing.name, path: '/call-coming');

  static const String name = 'CallComing';
}

/// generated route for
/// [_i8.HomeScreen]
class HomeScreen extends _i14.PageRouteInfo<void> {
  const HomeScreen({List<_i14.PageRouteInfo>? children})
      : super(HomeScreen.name, path: '/home-screen', initialChildren: children);

  static const String name = 'HomeScreen';
}

/// generated route for
/// [_i9.Chat]
class Chat extends _i14.PageRouteInfo<ChatArgs> {
  Chat(
      {_i15.Key? key,
      required bool comingFromMatchedPage,
      required _i17.SocketService socketService,
      _i18.User? connectedUser,
      _i19.Room? room,
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

  final _i15.Key? key;

  final bool comingFromMatchedPage;

  final _i17.SocketService socketService;

  final _i18.User? connectedUser;

  final _i19.Room? room;

  final String? userUUID;

  @override
  String toString() {
    return 'ChatArgs{key: $key, comingFromMatchedPage: $comingFromMatchedPage, socketService: $socketService, connectedUser: $connectedUser, room: $room, userUUID: $userUUID}';
  }
}

/// generated route for
/// [_i10.MatchFound]
class MatchFound extends _i14.PageRouteInfo<MatchFoundArgs> {
  MatchFound(
      {_i15.Key? key,
      required _i18.User user,
      required _i19.Room room,
      required String userUUID,
      required _i17.SocketService socketService})
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

  final _i15.Key? key;

  final _i18.User user;

  final _i19.Room room;

  final String userUUID;

  final _i17.SocketService socketService;

  @override
  String toString() {
    return 'MatchFoundArgs{key: $key, user: $user, room: $room, userUUID: $userUUID, socketService: $socketService}';
  }
}

/// generated route for
/// [_i11.MatchScreen]
class MatchScreen extends _i14.PageRouteInfo<void> {
  const MatchScreen() : super(MatchScreen.name, path: 'match-screen');

  static const String name = 'MatchScreen';
}

/// generated route for
/// [_i12.ProfileScreen]
class ProfileScreen extends _i14.PageRouteInfo<void> {
  const ProfileScreen() : super(ProfileScreen.name, path: 'profile-screen');

  static const String name = 'ProfileScreen';
}

/// generated route for
/// [_i13.ChatsScreen]
class ChatsScreen extends _i14.PageRouteInfo<void> {
  const ChatsScreen() : super(ChatsScreen.name, path: 'chats-screen');

  static const String name = 'ChatsScreen';
}
