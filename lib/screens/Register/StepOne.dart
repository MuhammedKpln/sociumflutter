import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

class RegisterScreenStepOne extends ConsumerStatefulWidget {
  RegisterScreenStepOne({Key? key}) : super(key: key);

  @override
  RegisterScreenStepOneState createState() => RegisterScreenStepOneState();
}

class RegisterScreenStepOneState extends ConsumerState<RegisterScreenStepOne> {
  final List<String> topics = [
    'İlgi alanlarınızı seçin',
  ];

  renderTopics(context) {
    return topics
        .map((topic) => Padding(
              padding: const EdgeInsets.all(10),
              child: RichText(
                text: TextSpan(children: [
                  const WidgetSpan(
                      child: Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Icon(Icons.check_circle_outline_rounded, size: 20),
                  )),
                  TextSpan(
                      text: topic,
                      style: TextStyle(
                          fontSize:
                              Theme.of(context).textTheme.titleLarge?.fontSize,
                          fontWeight: FontWeight.w300)),
                ]),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GradientText(
                "Socium'a hoşgeldiniz! Hadi başlıyalım",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: renderTopics(context),
                ),
              ),
              const Spacer(),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: RoundedButton(
                      child: const Text("Devam et"),
                      onPressed: () =>
                          context.router.navigate(RegisterScreenStepTwo())))
            ],
          )),
    );
  }
}
