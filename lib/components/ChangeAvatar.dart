import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scflutter/components/Avatar.dart';

import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:path/path.dart' as p;

import '../repositories/user.repository.dart';
import '../state/auth.state.dart';
import '../theme/toast.dart';

class ChangeAvatar extends ConsumerStatefulWidget {
  ChangeAvatar(
      {Key? key,
      required this.username,
      required this.isAuthenticatedUser,
      this.avatar})
      : super(key: key);

  String username;
  bool isAuthenticatedUser;
  String? avatar;

  @override
  _ChangeAvatarState createState() => _ChangeAvatarState();
}

class _ChangeAvatarState extends ConsumerState<ChangeAvatar>
    with NewLoadingMixin, TickerProviderStateMixin {
  final ImagePicker _picker = ImagePicker();
  final UserRepository _userRepository = UserRepository();

  Future<void> _upload(XFile imageFile) async {
    final user = ref.read(userProvider).rawUser;
    final userId = user!.id;
    final fileExt = p.extension(imageFile.path);
    final fileName = '${DateTime.now().toIso8601String()}$fileExt';
    final filePath = "$userId/$fileName";
    final bytes = await imageFile.readAsBytes();

    await _userRepository
        .uploadAvatar(filePath, bytes, userId)
        .then((_) => _onSuccesfull(_))
        .catchError(onError);
  }

  void _onSuccesfull(String? avatarPath) {
    if (avatarPath != null) {
      ref.read(userProvider.notifier).setAvatar(avatarPath);
      context.toast.showToast("success".tr(), toastType: ToastType.Success);
      return;
    }
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      await _upload(file);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isAuthenticatedUser = widget.isAuthenticatedUser;
    String username = widget.username;
    String? avatar = widget.avatar;

    if (isAuthenticatedUser) {
      final user = ref.watch(userProvider).user;
      username = user?.username ?? "noUsername";
      avatar = user?.avatar;
    }

    return Center(
      child: Column(children: [
        InkWell(
          onTap: isAuthenticatedUser ? _pickImage : null,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Avatar(
                username: username,
                avatarPath: avatar,
                avatarSize: AvatarSize.large,
              ),
              _renderIcon(),
            ],
          ),
        ),
      ]),
    );
  }

  Widget _renderIcon() {
    if (!widget.isAuthenticatedUser) return const SizedBox();

    return const Padding(
      padding: EdgeInsets.all(5),
      child: Icon(
        FeatherIcons.camera,
        size: 20,
      ),
    );
  }
}
