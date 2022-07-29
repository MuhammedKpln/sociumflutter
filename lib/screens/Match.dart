import 'package:auto_route/auto_route.dart';
import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/Match/Communities.dart';
import 'package:scflutter/components/Match/MatchFound.dart';
import 'package:scflutter/models/client_paired.dart';
import 'package:scflutter/models/message.dart';
import 'package:scflutter/services/websocket.events.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/theme/animation_durations.dart';
import 'package:scflutter/theme/animations.dart';
import 'package:scflutter/utils/palette.dart';

class MatchScreen extends ConsumerStatefulWidget {
  const MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  final sc = SocketService();
  late OverlayEntry overlayEntry;
  bool searchingForOpponent = false;
  int tabIndex = 0;

  @override
  void initState() {
    super.initState();

    sc.onClientPaired((data) {
      setState(() {
        searchingForOpponent = false;
      });

      ClientPaired formattedData = ClientPaired.fromJson(data);

      showDialog(
          context: context,
          barrierColor: const Color(0x00ffffff),
          barrierDismissible: false,
          builder: (context) => MatchFound(
                room: Room(
                    roomAdress: formattedData.room,
                    id: 0,
                    created_at: DateTime.now(),
                    expireDate: DateTime.now(),
                    updated_at: DateTime.now()),
                userUUID: formattedData.uuid,
                user: formattedData.user,
                socketService: sc,
              ));
    });
  }

  @override
  void dispose() {
    super.dispose();

    sc.eventEmitter.removeAllByEvent(SocketListenerEvents.CLIENT_PAIRED.path);
  }

  void onCancel() {
    AutoRouter.of(context).pop();
  }

  void joinQueue() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Eşleşme sırasına girdiniz! ")));
    final notifier = ref.read(userProvider.notifier);
    sc.joinQueue(notifier.state.user!);

    setState(() {
      searchingForOpponent = true;
    });
  }

  void leaveQueue() {
    sc.leaveQueue();

    setState(() {
      searchingForOpponent = false;
    });
  }

  void changeTab(int index) {
    setState(() {
      tabIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider.notifier);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(EvaIcons.moreHorizontal),
            onPressed: () => user.clearUser(),
          ),
          title: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () => changeTab(0),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      width: 100,
                      decoration: BoxDecoration(
                          color: tabIndex == 0 ? ColorPalette.primary : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(EvaIcons.globe,
                          color: ColorPalette.grey, size: 15),
                    ),
                  ),
                  InkWell(
                    onTap: () => changeTab(1),
                    child: Container(
                      width: 100,
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: tabIndex == 1 ? ColorPalette.primary : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Icon(EvaIcons.people,
                          size: 15, color: ColorPalette.grey),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
        body: tabIndex == 0 ? _Main(context) : const CommunitiesTab());
  }

  Widget _Main(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Column(
            children: [
              GradientText("Yeni insanlarla tanışın",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize:
                          Theme.of(context).textTheme.titleLarge?.fontSize)),
              Text(
                "Yeni insanlarla eşleşmek için, ara butonuna tıklayın!",
                style: Theme.of(context)
                    .textTheme
                    .labelLarge
                    ?.apply(color: Colors.grey.shade400),
              ),
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
              Animations.Search,
              width: 100,
              height: 100,
            ),
          ),
        ],
      ),
    );
  }
}
