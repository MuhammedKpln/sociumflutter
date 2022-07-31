// **************************************************************************
// AutoRouteGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouteGenerator
// **************************************************************************
//
// ignore_for_file: type=lint

import 'package:auto_route/auto_route.dart' as _i19;
import 'package:flutter/material.dart' as _i20;

import '../components/Match/MatchFound.dart' as _i10;
import '../guards/auth.guard.dart' as _i21;
import '../models/message.dart' as _i24;
import '../models/user_model.dart' as _i23;
import '../screens/Chat.dart' as _i9;
import '../screens/Chat/CallComing.dart' as _i7;
import '../screens/Chats.dart' as _i18;
import '../screens/Home.dart' as _i8;
import '../screens/Login.dart' as _i2;
import '../screens/Match.dart' as _i16;
import '../screens/Onboard.dart' as _i1;
import '../screens/Profile.dart' as _i17;
import '../screens/ProfileSettings/bio_settings.dart' as _i12;
import '../screens/ProfileSettings/BirthdaySettings.dart' as _i13;
import '../screens/ProfileSettings/BlockIncomingCalls.dart' as _i14;
import '../screens/ProfileSettings/ProfileSettings.dart' as _i11;
import '../screens/Register/StepFour.dart' as _i6;
import '../screens/Register/StepOne.dart' as _i3;
import '../screens/Register/StepThree.dart' as _i5;
import '../screens/Register/StepTwo.dart' as _i4;
import '../screens/testscreen.dart' as _i15;
import '../services/websocket.events.dart' as _i22;

class AppRouter extends _i19.RootStackRouter {
  AppRouter(
      {_i20.GlobalKey<_i20.NavigatorState>? navigatorKey,
      required this.authGuard})
      : super(navigatorKey);

  final _i21.AuthGuard authGuard;

  @override
  final Map<String, _i19.PageFactory> pagesMap = {
    OnboardScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i1.OnboardScreenPage());
    },
    LoginScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i2.LoginScreenPage());
    },
    RegisterScreenStepOneRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i3.RegisterScreenStepOnePage());
    },
    RegisterScreenStepTwoRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i4.RegisterScreenStepTwoPage());
    },
    RegisterStepThreeScreenRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterStepThreeScreenRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i5.RegisterStepThreeScreenPage(
              key: args.key, allowedChatMethods: args.allowedChatMethods));
    },
    RegisterScreenStepFourRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterScreenStepFourRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i6.RegisterScreenStepFourPage(
              key: args.key, email: args.email, username: args.username));
    },
    CallComingRoute.name: (routeData) {
      final args = routeData.argsAs<CallComingRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i7.CallComingPage(
              key: args.key,
              username: args.username,
              onAcceptCall: args.onAcceptCall,
              onRejectCall: args.onRejectCall),
          fullscreenDialog: true);
    },
    HomeScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i8.HomeScreenPage());
    },
    ChatScreenRoute.name: (routeData) {
      final args = routeData.argsAs<ChatScreenRouteArgs>();
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i9.ChatScreenPage(
              key: args.key,
              comingFromMatchedPage: args.comingFromMatchedPage,
              socketService: args.socketService,
              connectedUser: args.connectedUser,
              room: args.room,
              userUUID: args.userUUID));
    },
    MatchFound.name: (routeData) {
      final args = routeData.argsAs<MatchFoundArgs>();
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData,
          child: _i10.MatchFound(
              key: args.key,
              user: args.user,
              room: args.room,
              userUUID: args.userUUID,
              socketService: args.socketService),
          fullscreenDialog: true);
    },
    ProfileSettingsScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i11.ProfileSettingsScreenPage());
    },
    BioSettingsRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i12.BioSettingsPage());
    },
    BirthdaySettingsRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i13.BirthdaySettingsPage());
    },
    BlockIncomingCallsScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData,
          child: const _i14.BlockIncomingCallsScreenPage());
    },
    TestScreen.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i15.TestScreen());
    },
    MatchScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i16.MatchScreenPage());
    },
    ProfileRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i17.ProfilePage());
    },
    ChatsScreenRoute.name: (routeData) {
      return _i19.MaterialPageX<dynamic>(
          routeData: routeData, child: const _i18.ChatsScreenPage());
    }
  };

  @override
  List<_i19.RouteConfig> get routes => [
        _i19.RouteConfig(OnboardScreenRoute.name, path: '/'),
        _i19.RouteConfig(LoginScreenRoute.name, path: '/login-screen-page'),
        _i19.RouteConfig(RegisterScreenStepOneRoute.name,
            path: '/register-screen-step-one-page'),
        _i19.RouteConfig(RegisterScreenStepTwoRoute.name,
            path: '/register-screen-step-two-page'),
        _i19.RouteConfig(RegisterStepThreeScreenRoute.name,
            path: '/register-step-three-screen-page'),
        _i19.RouteConfig(RegisterScreenStepFourRoute.name,
            path: '/register-screen-step-four-page'),
        _i19.RouteConfig(CallComingRoute.name, path: '/call-coming-page'),
        _i19.RouteConfig(HomeScreenRoute.name,
            path: '/home-screen-page',
            guards: [
              authGuard
            ],
            children: [
              _i19.RouteConfig(MatchScreenRoute.name,
                  path: 'match-screen-page', parent: HomeScreenRoute.name),
              _i19.RouteConfig(ProfileRoute.name,
                  path: 'profile-page', parent: HomeScreenRoute.name),
              _i19.RouteConfig(ChatsScreenRoute.name,
                  path: 'chats-screen-page', parent: HomeScreenRoute.name)
            ]),
        _i19.RouteConfig(ChatScreenRoute.name, path: '/chat-screen-page'),
        _i19.RouteConfig(MatchFound.name, path: '/match-found'),
        _i19.RouteConfig(ProfileSettingsScreenRoute.name,
            path: '/profile-settings-screen-page'),
        _i19.RouteConfig(BioSettingsRoute.name, path: '/bio-settings-page'),
        _i19.RouteConfig(BirthdaySettingsRoute.name,
            path: '/birthday-settings-page'),
        _i19.RouteConfig(BlockIncomingCallsScreenRoute.name,
            path: '/block-incoming-calls-screen-page'),
        _i19.RouteConfig(TestScreen.name, path: '/test-screen')
      ];
}

/// generated route for
/// [_i1.OnboardScreenPage]
class OnboardScreenRoute extends _i19.PageRouteInfo<void> {
  const OnboardScreenRoute() : super(OnboardScreenRoute.name, path: '/');

  static const String name = 'OnboardScreenRoute';
}

/// generated route for
/// [_i2.LoginScreenPage]
class LoginScreenRoute extends _i19.PageRouteInfo<void> {
  const LoginScreenRoute()
      : super(LoginScreenRoute.name, path: '/login-screen-page');

  static const String name = 'LoginScreenRoute';
}

/// generated route for
/// [_i3.RegisterScreenStepOnePage]
class RegisterScreenStepOneRoute extends _i19.PageRouteInfo<void> {
  const RegisterScreenStepOneRoute()
      : super(RegisterScreenStepOneRoute.name,
            path: '/register-screen-step-one-page');

  static const String name = 'RegisterScreenStepOneRoute';
}

/// generated route for
/// [_i4.RegisterScreenStepTwoPage]
class RegisterScreenStepTwoRoute extends _i19.PageRouteInfo<void> {
  const RegisterScreenStepTwoRoute()
      : super(RegisterScreenStepTwoRoute.name,
            path: '/register-screen-step-two-page');

  static const String name = 'RegisterScreenStepTwoRoute';
}

/// generated route for
/// [_i5.RegisterStepThreeScreenPage]
class RegisterStepThreeScreenRoute
    extends _i19.PageRouteInfo<RegisterStepThreeScreenRouteArgs> {
  RegisterStepThreeScreenRoute(
      {_i20.Key? key, required dynamic allowedChatMethods})
      : super(RegisterStepThreeScreenRoute.name,
            path: '/register-step-three-screen-page',
            args: RegisterStepThreeScreenRouteArgs(
                key: key, allowedChatMethods: allowedChatMethods));

  static const String name = 'RegisterStepThreeScreenRoute';
}

class RegisterStepThreeScreenRouteArgs {
  const RegisterStepThreeScreenRouteArgs(
      {this.key, required this.allowedChatMethods});

  final _i20.Key? key;

  final dynamic allowedChatMethods;

  @override
  String toString() {
    return 'RegisterStepThreeScreenRouteArgs{key: $key, allowedChatMethods: $allowedChatMethods}';
  }
}

/// generated route for
/// [_i6.RegisterScreenStepFourPage]
class RegisterScreenStepFourRoute
    extends _i19.PageRouteInfo<RegisterScreenStepFourRouteArgs> {
  RegisterScreenStepFourRoute(
      {_i20.Key? key, required dynamic email, required dynamic username})
      : super(RegisterScreenStepFourRoute.name,
            path: '/register-screen-step-four-page',
            args: RegisterScreenStepFourRouteArgs(
                key: key, email: email, username: username));

  static const String name = 'RegisterScreenStepFourRoute';
}

class RegisterScreenStepFourRouteArgs {
  const RegisterScreenStepFourRouteArgs(
      {this.key, required this.email, required this.username});

  final _i20.Key? key;

  final dynamic email;

  final dynamic username;

  @override
  String toString() {
    return 'RegisterScreenStepFourRouteArgs{key: $key, email: $email, username: $username}';
  }
}

/// generated route for
/// [_i7.CallComingPage]
class CallComingRoute extends _i19.PageRouteInfo<CallComingRouteArgs> {
  CallComingRoute(
      {_i20.Key? key,
      required String username,
      required Function onAcceptCall,
      required Function onRejectCall})
      : super(CallComingRoute.name,
            path: '/call-coming-page',
            args: CallComingRouteArgs(
                key: key,
                username: username,
                onAcceptCall: onAcceptCall,
                onRejectCall: onRejectCall));

  static const String name = 'CallComingRoute';
}

class CallComingRouteArgs {
  const CallComingRouteArgs(
      {this.key,
      required this.username,
      required this.onAcceptCall,
      required this.onRejectCall});

  final _i20.Key? key;

  final String username;

  final Function onAcceptCall;

  final Function onRejectCall;

  @override
  String toString() {
    return 'CallComingRouteArgs{key: $key, username: $username, onAcceptCall: $onAcceptCall, onRejectCall: $onRejectCall}';
  }
}

/// generated route for
/// [_i8.HomeScreenPage]
class HomeScreenRoute extends _i19.PageRouteInfo<void> {
  const HomeScreenRoute({List<_i19.PageRouteInfo>? children})
      : super(HomeScreenRoute.name,
            path: '/home-screen-page', initialChildren: children);

  static const String name = 'HomeScreenRoute';
}

/// generated route for
/// [_i9.ChatScreenPage]
class ChatScreenRoute extends _i19.PageRouteInfo<ChatScreenRouteArgs> {
  ChatScreenRoute(
      {_i20.Key? key,
      required bool comingFromMatchedPage,
      required _i22.SocketService socketService,
      _i23.User? connectedUser,
      _i24.Room? room,
      String? userUUID})
      : super(ChatScreenRoute.name,
            path: '/chat-screen-page',
            args: ChatScreenRouteArgs(
                key: key,
                comingFromMatchedPage: comingFromMatchedPage,
                socketService: socketService,
                connectedUser: connectedUser,
                room: room,
                userUUID: userUUID));

  static const String name = 'ChatScreenRoute';
}

class ChatScreenRouteArgs {
  const ChatScreenRouteArgs(
      {this.key,
      required this.comingFromMatchedPage,
      required this.socketService,
      this.connectedUser,
      this.room,
      this.userUUID});

  final _i20.Key? key;

  final bool comingFromMatchedPage;

  final _i22.SocketService socketService;

  final _i23.User? connectedUser;

  final _i24.Room? room;

  final String? userUUID;

  @override
  String toString() {
    return 'ChatScreenRouteArgs{key: $key, comingFromMatchedPage: $comingFromMatchedPage, socketService: $socketService, connectedUser: $connectedUser, room: $room, userUUID: $userUUID}';
  }
}

/// generated route for
/// [_i10.MatchFound]
class MatchFound extends _i19.PageRouteInfo<MatchFoundArgs> {
  MatchFound(
      {_i20.Key? key,
      required _i23.User user,
      required _i24.Room room,
      required String userUUID,
      required _i22.SocketService socketService})
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

  final _i20.Key? key;

  final _i23.User user;

  final _i24.Room room;

  final String userUUID;

  final _i22.SocketService socketService;

  @override
  String toString() {
    return 'MatchFoundArgs{key: $key, user: $user, room: $room, userUUID: $userUUID, socketService: $socketService}';
  }
}

/// generated route for
/// [_i11.ProfileSettingsScreenPage]
class ProfileSettingsScreenRoute extends _i19.PageRouteInfo<void> {
  const ProfileSettingsScreenRoute()
      : super(ProfileSettingsScreenRoute.name,
            path: '/profile-settings-screen-page');

  static const String name = 'ProfileSettingsScreenRoute';
}

/// generated route for
/// [_i12.BioSettingsPage]
class BioSettingsRoute extends _i19.PageRouteInfo<void> {
  const BioSettingsRoute()
      : super(BioSettingsRoute.name, path: '/bio-settings-page');

  static const String name = 'BioSettingsRoute';
}

/// generated route for
/// [_i13.BirthdaySettingsPage]
class BirthdaySettingsRoute extends _i19.PageRouteInfo<void> {
  const BirthdaySettingsRoute()
      : super(BirthdaySettingsRoute.name, path: '/birthday-settings-page');

  static const String name = 'BirthdaySettingsRoute';
}

/// generated route for
/// [_i14.BlockIncomingCallsScreenPage]
class BlockIncomingCallsScreenRoute extends _i19.PageRouteInfo<void> {
  const BlockIncomingCallsScreenRoute()
      : super(BlockIncomingCallsScreenRoute.name,
            path: '/block-incoming-calls-screen-page');

  static const String name = 'BlockIncomingCallsScreenRoute';
}

/// generated route for
/// [_i15.TestScreen]
class TestScreen extends _i19.PageRouteInfo<void> {
  const TestScreen() : super(TestScreen.name, path: '/test-screen');

  static const String name = 'TestScreen';
}

/// generated route for
/// [_i16.MatchScreenPage]
class MatchScreenRoute extends _i19.PageRouteInfo<void> {
  const MatchScreenRoute()
      : super(MatchScreenRoute.name, path: 'match-screen-page');

  static const String name = 'MatchScreenRoute';
}

/// generated route for
/// [_i17.ProfilePage]
class ProfileRoute extends _i19.PageRouteInfo<void> {
  const ProfileRoute() : super(ProfileRoute.name, path: 'profile-page');

  static const String name = 'ProfileRoute';
}

/// generated route for
/// [_i18.ChatsScreenPage]
class ChatsScreenRoute extends _i19.PageRouteInfo<void> {
  const ChatsScreenRoute()
      : super(ChatsScreenRoute.name, path: 'chats-screen-page');

  static const String name = 'ChatsScreenRoute';
}
