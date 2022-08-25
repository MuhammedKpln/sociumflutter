import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scflutter/config.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/Core.mixin.dart';
import 'package:scflutter/repositories/user.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/utils/date.dart';

import '../../components/RoundedButton.dart';
import '../../components/Scaffold.dart';
import '../../theme/toast.dart';

class BirthdaySettingsPage extends ConsumerStatefulWidget {
  const BirthdaySettingsPage({Key? key}) : super(key: key);

  @override
  _BirthdaySettingsPageState createState() => _BirthdaySettingsPageState();
}

class _BirthdaySettingsPageState extends ConsumerState<BirthdaySettingsPage>
    with SociumCore {
  DateTime selectedDate = DateTime.now();
  final TextEditingController _controller = TextEditingController();
  final UserRepository _userRepository = UserRepository();

  @override
  void initState() {
    super.initState();

    _controller.text = formatDate(selectedDate);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  selectDate() async {
    final currentDate = DateTime.now();
    final maximumDate = Config.maximumDateForRegistration;

    final date = await showDatePicker(
        locale: EasyLocalization.of(context)?.currentLocale,
        context: context,
        initialDate: currentDate,
        firstDate: maximumDate,
        lastDate: currentDate);

    if (date != null) {
      final formattedDate = formatDate(date);
      _controller.text = formattedDate;

      setState(() {
        selectedDate = date;
      });
    }
  }

  void navigateBack() {
    context.router.navigateBack();
  }

  void onSuccess(DateTime birthday) {
    final userNotifier = ref.read(userProvider.notifier);

    userNotifier.setBirthday(birthday);

    context.toast.showToast("success".tr(), toastType: ToastType.Success);

    navigateBack();
  }

  void onError(error) {
    context.toast.showToast("fail".tr(), toastType: ToastType.Error);
    logError(error);
  }

  void updateBirthday() async {
    final user = ref.read(userProvider);
    final userId = user.user!.id;
    final updateData = {"birthday": selectedDate.toIso8601String()};

    _userRepository
        .updateProfile(updateData, userId)
        .then((value) => onSuccess(value.birthday!))
        .catchError(onError);
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(
        title: const Text("birthdaySettingsTitle").tr(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  TextField(
                    controller: _controller,
                    onTap: selectDate,
                    decoration: const InputDecoration(
                        icon: Icon(Icons.calendar_today), //icon of text field
                        labelText: "Enter Date" //label text of field
                        ),
                    readOnly: true,
                  )
                ],
              ),
            ),
            RoundedButton(
                onPressed: updateBirthday, child: const Text("save").tr())
          ],
        ),
      ),
    );
  }
}
