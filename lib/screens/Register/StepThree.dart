import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/utils/router.gr.dart';

import '../../components/Scaffold.dart';

class RegisterStepThreeScreenPage extends StatefulWidget {
  const RegisterStepThreeScreenPage(
      {Key? key, required this.allowedChatMethods})
      : super(key: key);

  final allowedChatMethods;

  @override
  State<RegisterStepThreeScreenPage> createState() =>
      _RegisterStepThreeScreenState();
}

class _RegisterStepThreeScreenState extends State<RegisterStepThreeScreenPage> {
  final emailFieldController = TextEditingController();
  final usernameFieldController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  final _usernameFormKey = GlobalKey<FormState>();

  onPressNext() {
    if (_formKey.currentState!.validate()) {
      AutoRouter.of(context).navigate(RegisterScreenStepFourRoute(
          email: emailFieldController.text,
          username: usernameFieldController.text));
    }
  }

  validateEmail(String? text) {
    if (text == null) {
      return "Lütfen geçerli bir e-posta adresi giriniz.";
    }

    bool validEmail = RegExp(
            r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
        .hasMatch(text);

    if (validEmail) {
      return null;
    }

    return "Lütfen geçerli bir e-posta adresi giriniz.";
  }

  usernameValidator(String? text) {
    if (text == null || text.length < 6) {
      return "Lütfen geçerli bir kullanıcı adı giriniz. (Min 6 karakter)";
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GradientText(
                "E-posta adresini ile kayıt olun",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _usernameFormKey,
                  child: TextFormField(
                    controller: usernameFieldController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    validator: (value) => usernameValidator(value),
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
                        hintText: "Kullanici adinizi giriniz"),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: emailFieldController,
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    validator: (value) => validateEmail(value),
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
                        hintText: "E-posta adresinizi giriniz"),
                  ),
                ),
              ),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: RoundedButton(
                      child: const Text("Devam et"),
                      onPressed: () => onPressNext())),
            ],
          )),
    );
  }
}
