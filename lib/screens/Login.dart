import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:scflutter/utils/router.gr.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/Scaffold.dart';

class LoginScreenPage extends ConsumerStatefulWidget {
  const LoginScreenPage({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends ConsumerState<LoginScreenPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _client = Supabase.instance.client;

  onError(GotrueError? error) {
    if (error?.message == "Email not confirmed") {
      context.toast
          .showToast("Email not confirmed", toastType: ToastType.Error);
    }

    context.toast
        .showToast("wrongLoginDetails".tr(), toastType: ToastType.Error);

    throw Exception(error);
  }

  login() async {
    final signIn = await _client.auth
        .signIn(email: emailController.text, password: passwordController.text);

    if (signIn.error != null) {
      onError(signIn.error);
    }

    final userModel = AuthStateModel(
        accessToken: signIn.data?.accessToken,
        user: signIn.data?.user,
        refreshToken: signIn.data?.refreshToken);

    ref.read(userProvider.notifier).setUser(userModel);

    context.router.replaceAll([const HomeScreenRoute()]);
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
                "onboardBottomSheetTitleText".tr(),
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
                        labelText: "loginEmailTextFieldPlaceholder".tr(),
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
                          labelText: "loginPasswordTextFieldPlaceholder".tr(),
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
              RoundedButton(
                onPressed: login,
                child: const Text("onboardLoginBtnText").tr(),
              )
            ],
          )),
    );
  }
}
