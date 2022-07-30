import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/serivces.dart';
import 'package:scflutter/storage/auth.storage.dart';

import '../state/auth.dart';

Future<String> getNewToken() async {
  final client = GraphQLClient(
      link: HttpLink(ApiService.GraphQLAPI.path), cache: GraphQLCache());
  final String refreshToken = await getRefreshToken();
  final User user = await getUser();
  final userId = user.id;
  final variables =
      RefreshTokenArguments(refreshToken: refreshToken, userId: userId ?? 0);

  final response = await client.mutate(
    MutationOptions(
        document: RefreshTokenMutation(variables: variables).document,
        variables: variables.toJson()),
  );

  final data = RefreshToken$Mutation.fromJson(response.data!);
  final userModel = AuthStateModel(
      accessToken: data.refreshToken.accessToken,
      refreshToken: data.refreshToken.refreshToken,
      user: user);

  await saveLogin(userModel);

  // ProviderContainer().read(userProvider.notifier).setUser(userModel);

  print("data.refreshToken.accessToken");
  return data.refreshToken.accessToken;
}
