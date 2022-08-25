import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/extensions/logger.extension.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/models/user.dart';
import 'package:scflutter/repositories/user.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';

import '../../components/Scaffold.dart';

class BioSettingsPage extends ConsumerStatefulWidget {
  const BioSettingsPage({Key? key}) : super(key: key);

  @override
  _BioSettingsPageState createState() => _BioSettingsPageState();
}

class _BioSettingsPageState extends ConsumerState<BioSettingsPage> {
  final textController = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();

    final userBio = ref.read(userProvider).user?.biography;

    textController.text = userBio ?? "";
  }

  @override
  void dispose() {
    textController.dispose();
    super.dispose();
  }

  void navigateBack() {
    context.router.navigateBack();
  }

  onSuccess(UserModel value) {
    final userNotifer = ref.read(userProvider.notifier);

    userNotifer.setBiography(value.biography!);

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
    final data = {"biography": textController.text};

    _userRepository
        .updateProfile(data, userId)
        .then(onSuccess)
        .catchError(onError);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text('Biyografini düzenle'),
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
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("bioSettingsTitle").tr(),
                  TextFormField(
                    controller: textController,
                    onChanged: (value) {
                      setState(() {});
                    },
                  ),
                ],
              ),
            ),
            RoundedButton(
              onPressed: updateProfile,
              child: const Text("save").tr(),
            )
          ],
        ),
      ),
    );
  }
}
