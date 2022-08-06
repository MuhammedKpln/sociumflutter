import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/graphql/graphql_api.graphql.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/theme/toast.dart';

import '../../components/Scaffold.dart';

class BioSettingsPage extends ConsumerStatefulWidget {
  const BioSettingsPage({Key? key}) : super(key: key);

  @override
  _BioSettingsPageState createState() => _BioSettingsPageState();
}

class _BioSettingsPageState extends ConsumerState<BioSettingsPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();

    final userBio = ref.read(userProvider).user?.bio;

    textController.text = userBio ?? "";
  }

  @override
  void dispose() {
    super.dispose();
    textController.dispose();
  }

  onError(OperationException? error) {
    print(error);
    context.toast.showToast("Lütfen daha sonra tekrar deneyiniz.",
        toastType: ToastType.Error);
  }

  onCompleted(Map<String, dynamic>? data) {
    if (data != null) {
      final user = ref.read(userProvider);
      final userNotifer = ref.read(userProvider.notifier);
      final parsedData = EditProfile$Mutation.fromJson(data);

      userNotifer.setBio(parsedData.editProfile.bio ?? "");

      scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Başarılı! ")));
      context.router.pop();
    }
  }

  updateCache(
      GraphQLDataProxy cache, QueryResult<EditProfile$Mutation>? result) {
    if (result?.data != null) {
      final parseResult = EditProfile$Mutation.fromJson(result!.data!);

      final variables =
          GetUserProfileArguments(username: parseResult.editProfile.username);
      final request = MutationOptions(
              document: GetUserProfileQuery(variables: variables).document,
              variables: variables.toJson())
          .asRequest;
      final query = cache.readQuery(request);
      if (query != null) {
        final parseQuery = GetUserProfile$Query.fromJson(query);

        parseQuery.getUser.bio = parseResult.editProfile.bio;

        cache.writeQuery(request, data: parseQuery.toJson());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final mutationVariables =
        EditProfileArguments(biography: textController.value.text);
    final mutationVariablesParsed = mutationVariables.toJson();
    final mutationDocument =
        EditProfileMutation(variables: mutationVariables).document;

    return AppScaffold(
      appBar: AppBar(
        title: const Text('Biyografini düzenle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade800),
                  borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Biyografi"),
                  TextFormField(
                    controller: textController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            Mutation(
                options: MutationOptions<EditProfile$Mutation>(
                    document: mutationDocument,
                    variables: mutationVariablesParsed,
                    onError: onError,
                    update: updateCache,
                    onCompleted: onCompleted),
                builder: (runMutation, result) {
                  return RoundedButton(
                      child: const Text("Kaydet"),
                      onPressed: () => runMutation(mutationVariablesParsed));
                }),
          ],
        ),
      ),
    );
  }
}
