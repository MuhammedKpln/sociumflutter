import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/repositories/user.repository.dart';
import 'package:scflutter/state/auth.state.dart';
import 'package:scflutter/theme/toast.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:path/path.dart' as p;

class ChangeAvatarPage extends ConsumerStatefulWidget {
  const ChangeAvatarPage({Key? key}) : super(key: key);

  @override
  _ChangeAvatarPageState createState() => _ChangeAvatarPageState();
}

class _ChangeAvatarPageState extends ConsumerState<ChangeAvatarPage>
    with NewLoadingMixin, TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  final UserRepository _userRepository = UserRepository();

  AppBar _renderAppBar() {
    return AppBar(
      title: const Text("changeAvatar").tr(),
    );
  }

  void _onSuccesfull(String? avatarPath) {
    if (avatarPath != null) {
      ref.read(userProvider.notifier).setAvatar(avatarPath);
      context.toast.showToast("success".tr(), toastType: ToastType.Success);
      return;
    }
  }

  Future<void> _upload(XFile imageFile) async {
    final user = ref.read(userProvider).rawUser;
    final userId = user!.id;
    final fileExt = p.extension(imageFile.path);
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = "$userId/$fileName";
    final bytes = await imageFile.readAsBytes();

    await _userRepository
        .uploadAvatar(filePath, bytes, userId)
        .then((_) => _onSuccesfull(_))
        .catchError(onError);
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      await _upload(file);
    }
  }

  Widget _build() {
    final user = ref.watch(userProvider).user;
    final userName = user!.username;
    final userAvatar = user.avatar;

    return Container(
      decoration: BoxDecoration(gradient: ColorPalette.surfaceLinearGradient),
      child: Center(
        child: Column(children: [
          InkWell(
            onTap: _pickImage,
            child: Avatar(
              username: userName,
              avatarPath: userAvatar,
              avatarSize: AvatarSize.large,
            ),
          ),
        ]),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: _renderAppBar(),
      body: _build(),
    );
  }
}
