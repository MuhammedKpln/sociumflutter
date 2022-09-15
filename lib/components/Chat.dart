import 'package:adaptive_dialog/adaptive_dialog.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_chat_ui/flutter_chat_ui.dart' as ui;
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:scflutter/theme/theme.dart';
import 'package:scflutter/theme/toast.dart';

import '../theme/animations.dart';
import 'LottieAnimation.dart';

enum _ChatActionKeys { copy, delete }

class Chat extends StatelessWidget {
  Chat(
      {super.key,
      required this.messages,
      required this.onPressSend,
      required this.user,
      required this.isLoading,
      required this.handlePreviewDataUpdateState,
      required this.onDeleteMessage,
      this.showAvatar,
      this.showUsername});

  List<types.Message> messages = [];
  Function(types.PartialText text) onPressSend;
  Function(int index, types.Message updatedMessage)
      handlePreviewDataUpdateState;
  Function(types.Message message) onDeleteMessage;

  types.User user;
  bool isLoading;
  bool? showUsername = false;
  bool? showAvatar = false;

  void _handlePreviewDataFetched(
    types.TextMessage message,
    types.PreviewData previewData,
  ) {
    final index = messages.indexWhere((element) => element.id == message.id);
    final updatedMessage = (messages[index] as types.TextMessage).copyWith(
      previewData: previewData,
    );

    handlePreviewDataUpdateState(index, updatedMessage);
  }

  Widget customBottomWidget() {
    if (!isLoading) {
      return LottieAnimation(
        animationPath: Animations.loadingDots.path,
        heigth: 70,
      );
    }

    return ui.Input(onSendPressed: onPressSend);
  }

  void _copyMessage(types.TextMessage message) async {
    await Clipboard.setData(ClipboardData(text: message.text));

    final args = {"message": message.text};

    const Toast().showToast("copiedSuccesfully".tr(namedArgs: args),
        toastType: ToastType.Success);
  }

  void onMessageLongPress(BuildContext context, types.Message message) async {
    List<SheetAction<_ChatActionKeys>> actions = [
      SheetAction(
          label: "deleteBtnText".tr(),
          isDestructiveAction: true,
          key: _ChatActionKeys.delete,
          icon: FeatherIcons.delete)
    ];

    if (message is types.TextMessage) {
      actions.insert(
          0,
          SheetAction(
            label: "copyBtnTxt".tr(),
            icon: FeatherIcons.copy,
            key: _ChatActionKeys.copy,
          ));
    }

    final action = await showModalActionSheet<_ChatActionKeys>(
        context: context, actions: actions, cancelLabel: "cancelBtnText".tr());

    switch (action) {
      case _ChatActionKeys.copy:
        _copyMessage(message as types.TextMessage);
        break;
      case _ChatActionKeys.delete:
        onDeleteMessage(message);
        break;

      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ui.Chat(
        messages: messages,
        onSendPressed: onPressSend,
        customBottomWidget: customBottomWidget(),
        user: user,
        onMessageLongPress: onMessageLongPress,
        showUserAvatars: showAvatar ?? false,
        showUserNames: showUsername ?? false,
        emojiEnlargementBehavior: ui.EmojiEnlargementBehavior.multi,
        previewTapOptions: const ui.PreviewTapOptions(
            openOnImageTap: true, openOnTitleTap: true),
        onPreviewDataFetched: _handlePreviewDataFetched,
        theme: SociumChatTheme,
        usePreviewData: true,
        inputOptions: ui.InputOptions(
            sendButtonVisibilityMode: !isLoading
                ? ui.SendButtonVisibilityMode.hidden
                : ui.SendButtonVisibilityMode.editing));
  }
}
