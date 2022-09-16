import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:scflutter/components/Avatar.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ChangeAvatarPage extends StatefulWidget {
  const ChangeAvatarPage({Key? key}) : super(key: key);

  @override
  State<ChangeAvatarPage> createState() => _ChangeAvatarPageState();
}

class _ChangeAvatarPageState extends State<ChangeAvatarPage> {
  final ImagePicker _picker = ImagePicker();

  AppBar _renderAppBar() {
    return AppBar(
      title: const Text("changeAvatar").tr(),
    );
  }

  Future<void> _upload(XFile imageFile) async {
    final fileExt = imageFile.path.split('.').last;
    final fileName = '${DateTime.now().toIso8601String()}.$fileExt';
    final filePath = fileName;
    final bytes = await imageFile.readAsBytes();

    final s = await Supabase.instance.client.storage
        .from("users")
        .uploadBinary(filePath, bytes);

    print(s.error);
    print(s.data);
  }

  Future<void> _pickImage() async {
    final file = await _picker.pickImage(source: ImageSource.gallery);

    if (file != null) {
      await _upload(file);
    }
  }

  Widget _build() {
    return Container(
      decoration: BoxDecoration(gradient: ColorPalette.surfaceLinearGradient),
      child: Center(
        child: Column(children: [
          InkWell(
            onTap: _pickImage,
            child: const Avatar(
              username: "username",
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
