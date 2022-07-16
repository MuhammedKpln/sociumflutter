import 'dart:math';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/graphql/graphql_api.graphql.dart';
import 'package:scflutter/utils/avatar.dart';
import "package:eventify/eventify.dart";

class MatchFound extends StatelessWidget {
  MatchFound({Key? key, required this.user, required this.onCancel})
      : super(key: key);

  Login$Mutation$Login$User user;
  Function onCancel;

  @override
  Widget build(BuildContext context) {
    final randomAvatar = generateRandomAvatar();

    return Positioned(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 3, sigmaY: 3),
            child: Stack(alignment: Alignment.center, children: [
              Lottie.asset("assets/animations/confetti.json"),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Image.network(
                        generateAvatarUrl(user.avatar ?? randomAvatar),
                        width: 100,
                        height: 100,
                        scale: 0.6,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          user.username,
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              decoration: TextDecoration.none),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      RoundedButton(
                        child: const Text("Esles"),
                        onPressed: () => null,
                      ),
                      ElevatedButton(
                          onPressed: () => onCancel(),
                          child: const Text("Iptal"))
                    ],
                  )
                ],
              ),
            ])));
  }
}
