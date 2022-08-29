import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/models/login_response.model.dart';
import 'package:scflutter/repositories/auth.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../../components/Scaffold.dart';
import '../../theme/toast.dart';

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
  final AuthRepository _authRepository = AuthRepository();
  final passwordController = TextEditingController();
  final passwordConfirmationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _confirmationFormKey = GlobalKey<FormState>();

  bool _validateInput() {
    if (_formKey.currentState!.validate() &&
        _confirmationFormKey.currentState!.validate()) {
      return true;
    }

    return false;
  }

  register() async {
    if (_validateInput()) {
      final signUp = _authRepository
          .signUp(
              email: widget.email,
              password: passwordController.text,
              username: widget.username)
          .then((value) => onSuccessfullLoginAttempt(value))
          .catchError((err) => onErrorLoginAttempt(err));
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

  onSuccessfullLoginAttempt(LoginResponse response) {
    final model = AuthStateModel(
        accessToken: response.accessToken,
        rawUser: response.rawUser,
        user: response.user,
        refreshToken: response.refreshToken);

    ref.read(userProvider.notifier).setUser(model);
    context.router.replaceAll([const HomeScreenRoute()]);
  }

  onErrorLoginAttempt(Exception error) {
    print(error);
    context.toast.showToast("Lütfen daha sonra tekrar deneyiniz.",
        toastType: ToastType.Error);
  }

  @override
  Widget build(BuildContext context) {
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
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: RoundedButton(
                      icon: null,
                      onPressed: register,
                      child: const Text("Kayıt ol")))
            ],
          )),
    );
  }
}
