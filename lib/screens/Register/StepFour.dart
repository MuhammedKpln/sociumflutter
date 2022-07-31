import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/main.dart';
import 'package:scflutter/models/user_model.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../../components/Scaffold.dart';

class RegisterScreenStepFourPage extends ConsumerStatefulWidget {
  const RegisterScreenStepFourPage(
      {Key? key, required this.email, required this.username})
      : super(key: key);

  final email;
  final username;

  @override
  RegisterScreenStepFourState createState() => RegisterScreenStepFourState();
}

class RegisterScreenStepFourState
    extends ConsumerState<RegisterScreenStepFourPage> {
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _confirmationFormKey = GlobalKey<FormState>();

  onPressNext(runMutation, QueryResult result, BuildContext context) {
    if (_formKey.currentState!.validate() &&
        _confirmationFormKey.currentState!.validate()) {
      runMutation({
        'email': widget.email,
        'username': widget.username,
        'password': passwordController.text,
        'passwordConfirmation': passwordConfirmationController.text
      });

      if (result.exception != null) {
        scaffoldKey.currentState?.showSnackBar(const SnackBar(
            content: Text("Lütfen daha sonra tekrar deneyiniz.")));

        // Timer(Duration(milliseconds: 500), () {
        //   AutoRouter.of(context).popUntilRoot();
        // });
      }
    }
  }

  validatePassword(String? text) {
    if (text == null || text.length < 6) {
      return "Lütfen geçerli bir parola giriniz. (Min 6 karakter)";
    }

    return null;
  }

  validatePasswordConfirmation(String? text) {
    if (text != passwordController.text) {
      return "Parolalar eşleşmiyor.";
    }

    return null;
  }

  onSuccessfullLoginAttempt(Map<String, dynamic> data) {
    final serializedData = Register$Mutation.fromJson(data);
    final userModel = Login$Mutation$Login$User.fromJson(
        serializedData.register.user.toJson());

    final currentUser = User.fromJson(userModel.toJson());

    ref.watch(userProvider.notifier).setUser(AuthStateModel(
        refreshToken: serializedData.register.refreshToken,
        user: currentUser,
        accessToken: serializedData.register.accessToken));

    context.router.replaceAll([const HomeScreenRoute()]);
  }

  onErrorLoginAttempt(OperationException? error) {
    scaffoldKey.currentState?.showSnackBar(
        const SnackBar(content: Text("Lütfen daha sonra tekrar deneyiniz.")));
  }

  @override
  Widget build(BuildContext context) {
    final registerArguments = RegisterArguments(
        email: widget.email,
        username: widget.username,
        password: passwordController.text,
        passwordConfirmation: passwordConfirmationController.text);

    return AppScaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GradientText(
                "Şifrenizi giriniz",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: passwordController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    validator: (value) => validatePassword(value),
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5?.fontSize,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.fontSize),
                        hintText: "Şifrenizi giriniz"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _confirmationFormKey,
                  child: TextFormField(
                    controller: passwordConfirmationController,
                    obscureText: true,
                    textAlign: TextAlign.center,
                    validator: (value) => validatePasswordConfirmation(value),
                    style: TextStyle(
                        fontSize:
                            Theme.of(context).textTheme.headline5?.fontSize,
                        fontWeight: FontWeight.bold),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        hintStyle: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: Theme.of(context)
                                .textTheme
                                .headline5
                                ?.fontSize),
                        hintText: "Şifrenizi giriniz (Tekrar)"),
                  ),
                ),
              ),
              Mutation(
                  options: MutationOptions(
                    document:
                        RegisterMutation(variables: registerArguments).document,
                    onCompleted: (data) => onSuccessfullLoginAttempt(data!),
                    onError: (error) => onErrorLoginAttempt(error),
                  ),
                  builder: (runMutation, result) {
                    return Container(
                        width: double.infinity,
                        margin: const EdgeInsets.all(30),
                        child: RoundedButton(
                            icon: result!.isLoading
                                ? const CircularProgressIndicator()
                                : null,
                            child: const Text("Kayıt ol"),
                            onPressed: () {
                              if (!result.isLoading) {
                                onPressNext(runMutation, result, context);
                              }
                            }));
                  }),
            ],
          )),
    );
  }
}
