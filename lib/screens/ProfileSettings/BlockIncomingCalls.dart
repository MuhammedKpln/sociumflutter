import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/graphql/graphql_api.graphql.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/state/auth.dart';

import '../../components/RoundedButton.dart';
import '../../components/Scaffold.dart';
import '../../theme/toast.dart';

class BlockIncomingCallsScreenPage extends ConsumerStatefulWidget {
  const BlockIncomingCallsScreenPage({Key? key}) : super(key: key);

  @override
  _BlockIncomingCallsScreenPageState createState() =>
      _BlockIncomingCallsScreenPageState();
}

class _BlockIncomingCallsScreenPageState
    extends ConsumerState<BlockIncomingCallsScreenPage> {
  bool blockIncomingCalls = false;

  @override
  void initState() {
    super.initState();

    setState(() {
      blockIncomingCalls =
          ref.read(userProvider).user?.blockIncomingCalls ?? false;
    });
  }

  onError(OperationException? error) {
    print(error);
    context.toast.showToast("Lütfen daha sonra tekrar deneyiniz.",
        toastType: ToastType.Error);
  }

  onCompleted(Map<String, dynamic>? data) {
    if (data != null) {
      final userNotifer = ref.read(userProvider.notifier);
      final parsedData = EditProfile$Mutation.fromJson(data);

      userNotifer.setBlockIncomingCalls(
          parsedData.editProfile.blockIncomingCalls ?? false);

      scaffoldKey.currentState
          ?.showSnackBar(const SnackBar(content: Text("Başarılı! ")));
      context.router.pop();
    }
  }

  onChangeSwitch(bool value) {
    setState(() {
      blockIncomingCalls = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    final mutationVariables =
        EditProfileArguments(blockIncomingCalls: blockIncomingCalls);
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
              child: Row(
                children: [
                  const Text("Gelen aramaları engelle"),
                  Switch(value: blockIncomingCalls, onChanged: onChangeSwitch),
                ],
              ),
            ),
            Mutation(
                options: MutationOptions<EditProfile$Mutation>(
                    document: mutationDocument,
                    variables: mutationVariablesParsed,
                    onError: onError,
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
