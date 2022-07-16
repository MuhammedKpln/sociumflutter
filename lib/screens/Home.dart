import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/storage/auth.storage.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notifier = ref.watch(userProvider.notifier);

    return AppScaffold(
      body: Text("S"),
    );
  }
}
