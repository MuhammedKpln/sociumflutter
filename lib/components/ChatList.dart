import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/models/message.model.dart';
import 'package:scflutter/models/room.dart';
import 'package:scflutter/models/user.dart';

import '../utils/palette.dart';
import 'Avatar.dart';
import 'Badge.dart';

class ChatList extends StatelessWidget {
  ChatList(
      {Key? key,
      required this.deleteRoom,
      required this.navigateToChat,
      required this.message,
      required this.user,
      required this.title,
      this.groupChat = false})
      : super(key: key);

  Function(int) deleteRoom;
  Function(UserModel, Room) navigateToChat;
  Message message;
  UserModel user;
  String title;
  bool? groupChat = false;

  Future<bool> confirmDeleting(
      BuildContext context, DismissDirection direction, String title) async {
    final intlArgs = {"name": title};

    final dialog = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: const Text("sureToDelete").tr(namedArgs: intlArgs),
          actions: [
            TextButton(
                onPressed: () => context.router.pop(false),
                child: const Text("cancelBtnTxt").tr()),
            ElevatedButton(
                onPressed: () => context.router.pop(true),
                child: const Text("deleteBtnTxt").tr()),
          ],
        );
      },
    );

    if (dialog != null) {
      return dialog;
    }

    return false;
  }

  Widget _renderBadge(bool messageSeen) {
    if (!messageSeen) {
      return const Padding(
          padding: EdgeInsets.only(right: 10), child: Badge(child: Text("1")));
    }

    return const SizedBox();
  }

  @override
  Widget build(BuildContext context) {
    Color textColor = Colors.grey;

    if (message.seen) {
      textColor = Colors.grey.shade600;
    }

    return Dismissible(
      confirmDismiss: (_) =>
          confirmDeleting(context, _, message.room_data!.name ?? "noName"),
      background: Container(
        padding: const EdgeInsets.all(5),
        alignment: Alignment.centerRight,
        color: ColorPalette.red,
        child: const Icon(FeatherIcons.trash2),
      ),
      key: Key(message.id.toString()),
      onDismissed: (_) => deleteRoom(message.room),
      child: InkWell(
        onTap: () => navigateToChat(user, message.room_data!),
        child: Row(
          children: [
            _renderBadge(message.seen),
            Avatar(
              avatarSize: AvatarSize.mediumish,
              username: title,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium
                        ?.copyWith(color: message.seen ? textColor : null),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Row(
                      children: [
                        if (groupChat!)
                          Avatar(
                            username: message.user_data!.username,
                            avatarPath: message.user_data?.avatar,
                            avatarSize: AvatarSize.extraSmall,
                          ),
                        Padding(
                          padding: groupChat!
                              ? const EdgeInsets.only(
                                  left: 5,
                                )
                              : const EdgeInsets.all(0),
                          child: Text(
                            message.text,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                ?.copyWith(
                                    color: message.seen ? textColor : null),
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
