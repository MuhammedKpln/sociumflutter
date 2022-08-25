import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/extensions/logger.extension.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/repositories/user.repository.dart';
import 'package:scflutter/state/auth.state.dart';

import '../../components/RoundedButton.dart';
import '../../components/Scaffold.dart';
import '../../models/user.dart';
import '../../theme/toast.dart';

class BlockIncomingCallsScreenPage extends ConsumerStatefulWidget {
  const BlockIncomingCallsScreenPage({Key? key}) : super(key: key);

  @override
  _BlockIncomingCallsScreenPageState createState() =>
      _BlockIncomingCallsScreenPageState();
}

class _BlockIncomingCallsScreenPageState
    extends ConsumerState<BlockIncomingCallsScreenPage> {
  bool blockIncomingCalls = false;
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();
    setState(() {
      blockIncomingCalls =
          ref.read(userProvider).user?.blockIncomingCalls ?? false;
    });
  }

  onChangeSwitch(bool value) {
    setState(() {
      blockIncomingCalls = value;
    });
  }

  void navigateBack() {
    context.router.navigateBack();
  }

  onSuccess(UserModel value) {
    final userNotifer = ref.read(userProvider.notifier);

    userNotifer.setBlockIncomingCalls(value.blockIncomingCalls!);

    context.toast.showToast("success".tr(), toastType: ToastType.Success);

    navigateBack();
  }

  onError(error) {
    context.toast.showToast("fail".tr(), toastType: ToastType.Error);
    context.logger.logError(error);
  }

  void updateProfile() async {
    final user = ref.read(userProvider);
    final userId = user.user!.id;
    final data = {"blockIncomingCalls": blockIncomingCalls};

    _userRepository
        .updateProfile(data, userId)
        .then((value) => onSuccess(value))
        .catchError(onError);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('blockIncomingCallsSettingsTitle').tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                  border: Border.all(width: 1, color: Colors.grey.shade800),
                  borderRadius: BorderRadius.circular(10)),
              child: Row(
                children: [
                  const Text("blockIncomingCallsSettingsTitle").tr(),
                  Switch(value: blockIncomingCalls, onChanged: onChangeSwitch),
                ],
              ),
            ),
            RoundedButton(
                onPressed: updateProfile, child: const Text("save").tr()),
          ],
        ),
      ),
    );
  }
}
