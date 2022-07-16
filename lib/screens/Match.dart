import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/Match/Communities.dart';
import 'package:scflutter/components/Match/MatchFound.dart';
import 'package:scflutter/graphql/graphql_api.dart';
import 'package:scflutter/services/websocket.service.dart';
import 'package:scflutter/state/auth.dart';
import 'package:scflutter/theme/animations.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart' as r;

class MatchScreen extends ConsumerStatefulWidget {
  MatchScreen({Key? key}) : super(key: key);

  @override
  _MatchScreenState createState() => _MatchScreenState();
}

class _MatchScreenState extends ConsumerState<MatchScreen> {
  final sc = Socket();
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
      Login$Mutation$Login$User opponent =
          Login$Mutation$Login$User.fromJson(data["user"]);

      OverlayState? overlayState = Overlay.of(context);

      overlayEntry = OverlayEntry(
          opaque: false,
          builder: (context) {
            return MatchFound(
              user: opponent,
              onCancel: onCancel,
            );
          });

      overlayState?.insert(overlayEntry);
    });
  }

  void onCancel() {
    overlayEntry.remove();
  }

  void joinQueue() {
    final notifier = ref.read(userProvider.notifier);
    sc.joinQueue(notifier.state.user);

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
    return Scaffold(
        appBar: AppBar(
          leading: Icon(Icons.settings),
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
                      width: 100,
                      decoration: BoxDecoration(
                          color: tabIndex == 0 ? ColorPalette.primary : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(Icons.settings),
                    ),
                  ),
                  InkWell(
                    onTap: () => changeTab(1),
                    child: Container(
                      width: 100,
                      decoration: BoxDecoration(
                          color: tabIndex == 1 ? ColorPalette.primary : null,
                          borderRadius: BorderRadius.circular(20)),
                      child: Icon(Icons.settings),
                    ),
                  )
                ],
              ),
            )
          ]),
        ),
        body: tabIndex == 0 ? Main(context) : CommunitiesTab());
  }

  Widget Main(BuildContext context) {
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
          searchingForOpponent ? SearchingButton() : SearchButton()
          // Lottie.asset("assets/animations/search.json"),
        ],
      ),
    );
  }

  Widget SearchButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 200),
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(100),
            gradient: LinearGradient(colors: [
              ColorPalette.primary,
              Colors.orange.shade300,
            ])),
        child: InkWell(
          onTap: joinQueue,
          child: const Icon(
            Icons.search,
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget SearchingButton() {
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
