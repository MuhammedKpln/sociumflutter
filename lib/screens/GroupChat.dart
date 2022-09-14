import 'package:flutter/material.dart';
import 'package:scflutter/components/LoadingNew.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/extensions/theme.extension.dart';
import 'package:scflutter/mixins/NewLoading.mixin.dart';
import 'package:scflutter/models/room.dart';

class GroupChatPage extends StatefulWidget {
  GroupChatPage({super.key, required this.roomDetails});

  Room roomDetails;

  @override
  State<GroupChatPage> createState() => _GroupChatPageState();
}

class _GroupChatPageState extends State<GroupChatPage>
    with NewLoadingMixin, TickerProviderStateMixin {
  Widget _renderUserAvatar(String username) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CircleAvatar(
        child: Text(
          username[0],
          style: const TextStyle(fontSize: 10),
        ),
      ),
    );
  }

  _renderAppBar() {
    final roomPartipications =
        widget.roomDetails.room_partipications_data?.take(2).toList();

    final roomPartipicationsAsWidget = roomPartipications?.map((e) {
      final index = roomPartipications.indexOf(e);

      if (index != 0) {
        return _renderUserAvatar(e.user_data?.username ?? "NoUsername");
      }

      return Positioned(
          left: 10,
          child: _renderUserAvatar(e.user_data?.username ?? "NoUsername"));
    }).toList();

    return AppBar(
      title: Loading(
        type: LoadingType.singleLine,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              widget.roomDetails.name ?? "No name",
              style: context.textStyles.titleSmall,
            ),
            Stack(
                clipBehavior: Clip.none,
                fit: StackFit.passthrough,
                children: roomPartipicationsAsWidget ?? []),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(appBar: _renderAppBar(), body: Container());
  }
}
