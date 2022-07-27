import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/services/token.service.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage/auth.storage.dart';
import 'package:scflutter/utils/logger.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  List<Function> pendingRequests = [];
  resolvePendingRequests() {
    pendingRequests.map((e) => e());
    pendingRequests = [];
  }

  bool isRefreshing = false;

  await initHiveForFlutter();

  final httpLink = HttpLink("http://localhost:3000/graphql");
  final authLink = AuthLink(getToken: (() async {
    final loggedIn = await isLoggedIn();

    print(loggedIn);
    if (loggedIn) {
      final accessToken = await getAccessToken();
      print(accessToken);

      return "Bearer $accessToken";
    }

    return null;
  }));

  final errorLink = ErrorLink(
    onGraphQLError: (request, forward, response) {
      print("response.errors");

      response.errors?.forEach((error) {
        if (error.message == 'Refresh token mismatch') {
          ProviderContainer().read(userProvider.notifier).clearUser();
        }

        if (error.message == "JWT_EXPIRED") {
          print("response asldkqlwe updating");

          if (!isRefreshing) {
            isRefreshing = true;

            getNewToken().then((value) {
              resolvePendingRequests();
            }).catchError((error) {
              Logger().error(error);
              pendingRequests = [];
            }).whenComplete(() {
              isRefreshing = true;
            });
          } else {
            pendingRequests.add(() => forward(request));
          }
        }

        if (error.message == "jwt malformed") {
          print("response asldkqlwe");
          ProviderContainer().read(userProvider.notifier).clearUser();
        }
      });

      return null;
    },
  );

  ValueNotifier<GraphQLClient> client = ValueNotifier(
    GraphQLClient(
      link: Link.from([authLink, httpLink]),
      // The default store is the InMemoryStore, which does NOT persist to disk
      cache: GraphQLCache(),
    ),
  );

  runApp(GraphQLProvider(
      client: client, child: ProviderScope(child: SociumApplication())));
}

class SociumApplication extends ConsumerWidget {
  final _appRouter = AppRouter(authGuard: AuthGuard());

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      scaffoldMessengerKey: scaffoldKey,
      theme: Theme.of(context).copyWith(
        iconTheme: const IconThemeData(color: Colors.white),
        appBarTheme: const AppBarTheme(
            backgroundColor: ColorPalette.background,
            elevation: 0,
            iconTheme: IconThemeData(color: Colors.grey)),
        scaffoldBackgroundColor: ColorPalette.background,
        primaryColor: ColorPalette.primary,
        buttonTheme: const ButtonThemeData(
          buttonColor: ColorPalette.primary,
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            backgroundColor: ColorPalette.background,
            selectedIconTheme: const IconThemeData(color: ColorPalette.primary),
            unselectedItemColor: Colors.grey.shade500),
        textTheme: Theme.of(context).textTheme.apply(
              bodyColor: Colors.white,
              displayColor: Colors.white,
            ),
        snackBarTheme:
            const SnackBarThemeData(backgroundColor: ColorPalette.primary),
        textButtonTheme: TextButtonThemeData(
            style: ButtonStyle(
                foregroundColor: MaterialStateProperty.all(ColorPalette.grey),
                textStyle: MaterialStateProperty.all(const TextStyle(
                  color: ColorPalette.grey,
                )))),
      ),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
