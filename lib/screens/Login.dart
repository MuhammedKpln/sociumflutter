import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/graphql/graphql_api.graphql.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../components/Scaffold.dart';

class LoginScreenPage extends ConsumerStatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginScreenPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    //FIXME: remove after testing.
    context.router.navigate(const InCallManagerScreenRoute());
    super.initState();
  }

  onPressLogin(RunMutation runMutation, QueryResult<Object?>? result) {
    runMutation({
      "email": emailController.text,
      "password": passwordController.text,
    });
  }

  onCompleted(Map<String, dynamic>? result) async {
    if (result != null) {
      final data = Login$Mutation.fromJson(result);
      final currentUser = User.fromJson(data.login.user.toJson());
      final authState = ref.read(userProvider.notifier);
      final model = AuthStateModel(
          refreshToken: data.login.refreshToken,
          accessToken: data.login.accessToken,
          user: currentUser);

      await authState.setUser(model);

      AutoRouter.of(context).replaceAll([const HomeScreenRoute()]);
    }
  }

  onError(OperationException? error) {
    print(error);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Text("Lütfen e-posta adresinizi ve şifrenizi kontrol ediniz."),
    ));
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GradientText(
                "Giriş yap",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Form(
                        child: TextFormField(
                      keyboardType: TextInputType.emailAddress,
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: "E-posta",
                        floatingLabelBehavior: FloatingLabelBehavior.never,
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide:
                              const BorderSide(color: Colors.grey, width: 1.0),
                        ),
                        labelStyle: const TextStyle(color: Colors.grey),
                      ),
                    )),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Form(
                          child: TextFormField(
                        controller: passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          labelText: "Şifre",
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: Colors.grey, width: 1.0),
                          ),
                          enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                  color: Colors.grey, width: 1.0)),
                          labelStyle: const TextStyle(color: Colors.grey),
                        ),
                      )),
                    )
                  ],
                ),
              ),
              const Spacer(),
              Mutation(
                  options: MutationOptions(
                      document: LoginMutation(
                              variables: LoginArguments(
                                  email: emailController.text,
                                  password: passwordController.text))
                          .document,
                      onCompleted: (result) => onCompleted(result),
                      onError: (err) => onError(err)),
                  builder: (runMutation, result) {
                    if (result!.isLoading) {
                      return RoundedButton(
                        child: const CircularProgressIndicator.adaptive(),
                        onPressed: () => null,
                      );
                    }

                    return RoundedButton(
                      child: const Text("Giriş yap"),
                      onPressed: () => runMutation(LoginArguments(
                              email: emailController.text,
                              password: passwordController.text)
                          .toJson()),
                    );
                  }),
            ],
          )),
    );
  }
}
