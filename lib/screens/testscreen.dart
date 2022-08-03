import 'package:flutter/material.dart';
import 'package:scflutter/components/Scaffold.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({Key? key}) : super(key: key);

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  void dispose() {
    super.dispose();

    // micMuted.dispose();
  }

  @override
  void initState() {
    super.initState();

    // micMuted.addListener(() {
    //   if (micMuted.value) {
    //     print("mic muted");
    //     scaffoldKey.currentState
    //         ?.showSnackBar(const SnackBar(content: Text("mic muted")));
    //   } else {
    //     print("mic unmuted");

    //     scaffoldKey.currentState
    //         ?.showSnackBar(const SnackBar(content: Text("mic muted")));
    //   }
    // });
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Container(
            child: const Text("test"),
          ),
        ],
      ),
    );
  }
}
