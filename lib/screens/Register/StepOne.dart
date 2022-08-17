import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/utils/router.gr.dart';
import '../../components/Scaffold.dart';

class RegisterScreenStepOnePage extends StatefulWidget {
  const RegisterScreenStepOnePage({Key? key}) : super(key: key);

  @override
  RegisterScreenStepOneState createState() => RegisterScreenStepOneState();
}

class RegisterScreenStepOneState extends State<RegisterScreenStepOnePage> {
  @override
  Widget build(BuildContext context) {
    renderTopics() {
      final List<String> topics = [
        "registerWelcomeTopicOne".tr(),
      ];

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
                            fontSize: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.fontSize,
                            fontWeight: FontWeight.w300)),
                  ]),
                ),
              ))
          .toList();
    }

    return AppScaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GradientText(
                "registerWelcomeText".tr(),
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              Container(
                margin: const EdgeInsets.only(top: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: renderTopics(),
                ),
              ),
              const Spacer(),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: RoundedButton(
                      child: const Text("registerContinueBtnTxt").tr(),
                      onPressed: () => context.router
                          .navigate(const RegisterScreenStepTwoRoute())))
            ],
          )),
    );
  }
}
