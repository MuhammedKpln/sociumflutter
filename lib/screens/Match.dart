import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/extensions/toastExtension.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/theme/animations.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../components/Match/MatchFound.dart';
import '../models/client_paired.dart';
import '../state/auth.state.dart';
import '../theme/toast.dart';

class MatchScreenPage extends ConsumerStatefulWidget {
  const MatchScreenPage({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreenPage> {
  final client = Supabase.instance.client;
  final PageController _pageController = PageController();
  late OverlayEntry overlayEntry;
  bool searchingForOpponent = false;
  int tabIndex = 0;
  SocketService socketService = SocketService();

  @override
  void initState() {
    // client.cha
    super.initState();

    _pageController.addListener(() {
      setState(() {
        tabIndex = _pageController.page!.round();
      });
    });
    socketService.onClientPaired((data) async {
      ClientPaired formattedData = ClientPaired.fromJson(data);

      await showDialog(
          context: context,
          barrierColor: const Color(0x00ffffff),
          barrierDismissible: false,
          builder: (context) => MatchFound(
                room: formattedData.room,
                userUUID: formattedData.uuid,
                user: formattedData.user,
                socketService: socketService,
              ));
      setState(() {
        searchingForOpponent = false;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();

    socketService.socket.off(SocketListenerEvents.CLIENT_PAIRED.path);
  }

  void onCancel() {
    AutoRouter.of(context).pop();
  }

  void joinQueue() {
    //TODO: IMPLEMENT SOCKET WITH SUPABASE
    context.toast
        .showToast("matchScreenJoinedQueue".tr(), toastType: ToastType.Success);

    final notifier = ref.read(userProvider);
    socketService.joinQueue(notifier.user!);

    setState(() {
      searchingForOpponent = true;
    });
  }

  void leaveQueue() {
    socketService.leaveQueue();

    setState(() {
      searchingForOpponent = false;
    });
  }

  void changeTab(int index) async {
    await _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 200), curve: Curves.ease);
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider.notifier);

    return AppScaffold(body: _Main());
  }

  Widget _Main() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              GradientText("matchScreenTitle".tr(),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize)),
              Text(
                "matchScreenDescription",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.apply(color: Colors.grey.shade400),
              ).tr(),
            ],
          ),
          AnimatedCrossFade(
              firstChild: _SearchingButton(),
              secondChild: _SearchButton(),
              crossFadeState: searchingForOpponent
                  ? CrossFadeState.showFirst
                  : CrossFadeState.showSecond,
              duration: Duration(
                  milliseconds: AnimationDurations.low
                      .duration)) // Lottie.asset("assets/animations/search.json"),
        ],
      ),
    );
  }

  Widget _SearchButton() {
    return Container(
      padding: const EdgeInsets.all(50),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(200),
          border:
              Border.all(color: ColorPalette.grey.withOpacity(0.4), width: 1)),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(200),
            border: Border.all(
                color: ColorPalette.grey.withOpacity(0.4), width: 1)),
        child: GestureDetector(
          onTap: joinQueue,
          child: Container(
            width: 100,
            height: 100,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                gradient: LinearGradient(colors: [
                  ColorPalette.primary,
                  Colors.orange.shade300,
                ])),
            child: const Icon(
              Icons.search,
              size: 30,
            ),
          ),
        ),
      ),
    );
  }

  Widget _SearchingButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Stack(
        alignment: Alignment.center,
        children: [
          GestureDetector(
            onTap: leaveQueue,
            child: Lottie.asset(
              Animations.search.path,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
