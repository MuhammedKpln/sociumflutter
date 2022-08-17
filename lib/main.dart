import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/serivces.dart';
import 'package:scflutter/services/token.service.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage/auth.storage.dart';
import 'package:scflutter/theme/theme.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';

import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';

class AuthToken extends ContextEntry {
  final String token;

  const AuthToken({required this.token});

  @override
  List<Object> get fieldsForEquality => [];
}

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await initHiveForFlutter();

  if (defaultTargetPlatform != TargetPlatform.macOS && !kDebugMode) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);

    FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;
  }

  final httpLink = HttpLink(ApiService.GraphQLAPI.path);
  final authLink = AuthLink(getToken: (() async {
    final loggedIn = await isLoggedIn();

    if (loggedIn) {
      final accessToken = await getAccessToken();

      return "Bearer $accessToken";
    }

    return null;
  }));

  final errorLink = ErrorLink(
    onGraphQLError: (request, forward, response) async* {
      final error = response.errors?[0];

      if (error?.message == 'Refresh token mismatch') {
        ProviderContainer().read(userProvider.notifier).clearUser();
      }

      if (error?.message == "JWT_EXPIRED" || error?.message == "jwt expired") {
        try {
          final token = await getNewToken();

          final updatedRequest =
              request.withContextEntry(AuthToken(token: token));

          yield* forward(updatedRequest);
        } catch (err) {
          await deleteUser();
          yield* forward(request);
        }
      }

      if (error?.message == "jwt malformed") {
        ProviderContainer().read(userProvider.notifier).clearUser();
      }
    },
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: Link.from([errorLink, authLink, httpLink]),
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
    ),
  );

  runApp(EasyLocalization(
    path: "assets/i18n",
    supportedLocales: const [Locale('en'), Locale('tr')],
    assetLoader: const CodegenLoader(),
    fallbackLocale: const Locale('en'),
    child: GraphQLProvider(
        client: client, child: ProviderScope(child: SociumApplication())),
  ));
}

class SociumApplication extends ConsumerWidget {
  final _appRouter = AppRouter(authGuard: AuthGuard());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        ...context.localizationDelegates,
      ],
      title: 'Flutter Demo',
      scaffoldMessengerKey: scaffoldKey,
      theme: SociumTheme(context),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
      supportedLocales: context.supportedLocales,
    );
  }
}
