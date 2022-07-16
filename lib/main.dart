import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gql_http_link/gql_http_link.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  await initHiveForFlutter();

  final link = HttpLink("http://localhost:3000/graphql");

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: link,
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(store: HiveStore()),
    ),
  );

  runApp(ProviderScope(
      child: GraphQLProvider(client: client, child: SociumApplication())));
}

class SociumApplication extends ConsumerWidget {
  final _appRouter = AppRouter(authGuard: AuthGuard());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      scaffoldMessengerKey: scaffoldKey,
      theme: Theme.of(context).copyWith(
          iconTheme: IconThemeData(color: Colors.white),
          appBarTheme: const AppBarTheme(
              backgroundColor: ColorPalette.background,
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.grey)),
          scaffoldBackgroundColor: ColorPalette.background,
          primaryColor: ColorPalette.primary,
          buttonTheme: ButtonThemeData(
            buttonColor: ColorPalette.primary,
          ),
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
              backgroundColor: ColorPalette.background,
              selectedIconTheme: IconThemeData(color: ColorPalette.primary),
              unselectedItemColor: Colors.grey.shade500),
          textTheme: Theme.of(context).textTheme.apply(
                bodyColor: Colors.white,
                displayColor: Colors.white,
              )),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
