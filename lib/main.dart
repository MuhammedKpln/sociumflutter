import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/guards/auth.guard.dart';
import 'package:scflutter/serivces.dart';
import 'package:scflutter/services/token.service.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage/auth.storage.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

class AuthToken extends ContextEntry {
  final String token;

  const AuthToken({required this.token});

  @override
  List<Object> get fieldsForEquality => [];
}

final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
Future<void> main() async {
  await initHiveForFlutter();

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
              selectedIconTheme:
                  const IconThemeData(color: ColorPalette.primary),
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
          bottomSheetTheme: const BottomSheetThemeData(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10))),
            clipBehavior: Clip.antiAliasWithSaveLayer,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: ColorPalette.primary),
          inputDecorationTheme:
              const InputDecorationTheme(border: InputBorder.none),
          dividerColor: Colors.grey.shade700),
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
