import 'package:auto_route/auto_route.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/config.dart';
import 'package:scflutter/graphql/graphql_api.graphql.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/state/auth.dart';

import '../../components/RoundedButton.dart';
import '../../components/Scaffold.dart';

class BirthdaySettingsPage extends ConsumerStatefulWidget {
  const BirthdaySettingsPage({Key? key}) : super(key: key);

  @override
  _BirthdaySettingsPageState createState() => _BirthdaySettingsPageState();
}

class _BirthdaySettingsPageState extends ConsumerState<BirthdaySettingsPage> {
  DateTime selectedDate = DateTime.now();

  onError(OperationException? error) {
    print(error);
    scaffoldKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Lütfen daha sonra tekrar deneyiniz.")));
  }

  onCompleted(Map<String, dynamic>? data) {
    if (data != null) {
      final userNotifer = ref.read(userProvider.notifier);
      final parsedData = EditProfile$Mutation.fromJson(data);

      userNotifer
          .setBirthday(parsedData.editProfile.birthday ?? DateTime.now());

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

        parseQuery.getUser.birthday = parseResult.editProfile.birthday;

        cache.writeQuery(request, data: parseQuery.toJson());
      }
    }
  }

  selectDate() async {
    final todaysDate = DateTime.now();
    final maximumDate = Config.maximumDateForRegistration;
    final minimumDate = Config.minimumDateForRegistration;

    final date = await showDatePicker(
        locale: const Locale('tr'),
        context: context,
        initialDate: maximumDate,
        firstDate: DateTime(1980),
        lastDate: maximumDate);

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.read(userProvider).user;
    final mutationVariables = EditProfileArguments(birthday: selectedDate);
    final mutationVariablesParsed = mutationVariables.toJson();
    final mutationDocument =
        EditProfileMutation(variables: mutationVariables).document;

    return AppScaffold(
      appBar: AppBar(
        title: const Text("Doğum günü"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  const Text("Doğum tarihi"),
                  RoundedButton(
                      onPressed: selectDate,
                      child: Text(formatDate(
                          selectedDate, [dd, ' ', MM, ' ', yyyy],
                          locale: const TurkishDateLocale())))
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
