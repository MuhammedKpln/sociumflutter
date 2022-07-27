import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/utils/router.gr.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(userProvider);

    if (notifier.accessToken == null) {
      AutoRouter.of(context).replaceAll([const OnboardScreen()]);
    }

    return AppScaffold(
      body: const Text("S"),
    );
  }
}
