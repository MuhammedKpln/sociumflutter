import 'package:auto_route/auto_route.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/config.dart';
import 'package:scflutter/serivces.dart';
import 'package:scflutter/theme/theme.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'firebase_options.dart';
import 'generated/codegen_loader.g.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Supabase.initialize(
      url: ApiService.SupabaseUrl.path,
      anonKey: Config.SupabaseAnonKey,
      debug: kDebugMode,
      localStorage: const HiveLocalStorage());

  if (defaultTargetPlatform != TargetPlatform.macOS && !kDebugMode) {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = Logger().logError;
  }

  runApp(EasyLocalization(
    path: "assets/i18n",
    supportedLocales: const [Locale('en'), Locale('tr')],
    assetLoader: const CodegenLoader(),
    fallbackLocale: const Locale('en'),
    child: ProviderScope(child: SociumApplication()),
  ));
}

class SociumApplication extends ConsumerWidget {
  final _appRouter = AppRouter();

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
      routerDelegate: AutoRouterDelegate(_appRouter,
          navigatorObservers: () => [AutoRouteObserver()]),
      routeInformationParser: _appRouter.defaultRouteParser(),
      supportedLocales: context.supportedLocales,
    );
  }
}
