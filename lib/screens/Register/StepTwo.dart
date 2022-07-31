import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/components/RoundedButton.dart';
import 'package:scflutter/components/Scaffold.dart';
import 'package:scflutter/utils/palette.dart';
import 'package:scflutter/utils/router.gr.dart';

class RegisterScreenStepTwoPage extends StatefulWidget {
  const RegisterScreenStepTwoPage({Key? key}) : super(key: key);

  @override
  State<RegisterScreenStepTwoPage> createState() =>
      _RegisterScreenStepTwoState();
}

class _RegisterScreenStepTwoState extends State<RegisterScreenStepTwoPage> {
  List<int> selectedItems = [1];

  final List<Map<String, dynamic>> items = [
    {
      "id": 0,
      "icon": Icons.message_outlined,
      "title": "Sohbet",
      "description": "İnsanlarla sadece sohbet yapmak için eşleşin."
    },
    {
      "id": 1,
      "icon": Icons.mic_rounded,
      "title": "Sesli sohbet",
      "description": "Ses yoluyla gerçek zamanlı konuşmak için eşleşin."
    },
  ];

  void onSelectItem(int itemId) {
    setState(() {
      if (selectedItems.contains(itemId)) {
        selectedItems.remove(itemId);
      } else {
        selectedItems.add(itemId);
      }
    });
  }

  Widget renderPopularBadge() {
    return Container(
        width: 80,
        margin: const EdgeInsets.only(left: 10),
        padding: const EdgeInsets.all(3),
        decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              ColorPalette.primary,
              ColorPalette.primary.withOpacity(0.5),
            ]),
            borderRadius: BorderRadius.circular(100)),
        child: Row(
          children: [
            const Icon(
              Icons.star_outline,
              size: 15,
            ),
            Text("Popüler",
                style: TextStyle(
                    fontSize: Theme.of(context).textTheme.bodySmall?.fontSize,
                    fontWeight: FontWeight.bold)),
          ],
        ));
  }

  Widget renderListItem(item) {
    final id = item["id"];
    final icon = item["icon"];
    final title = item["title"];
    final description = item["description"];

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: ColorPalette.surface,
          gradient: selectedItems.contains(id)
              ? LinearGradient(colors: [
                  ColorPalette.primary.withOpacity(0.6),
                  ColorPalette.primary.withOpacity(0.9),
                ], tileMode: TileMode.mirror)
              : null),
      child: InkWell(
        onTap: () => onSelectItem(id),
        child: Row(
          children: [
            Icon(
              icon,
              size: 30,
              color: Colors.grey.shade700,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: title,
                          children: [
                            WidgetSpan(
                                child: id == 1
                                    ? renderPopularBadge()
                                    : Container())
                          ],
                          style: TextStyle(
                              fontSize: Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontSize,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Text(description, overflow: TextOverflow.fade),
                      )
                    ]),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GradientText(
                "Nasıl eşleşmek istersiniz?",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: Theme.of(context).textTheme.headline5?.fontSize),
              ),
              Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return renderListItem(items[index]);
                      },
                      itemCount: 2,
                      separatorBuilder: (context, index) {
                        return const SizedBox(height: 20);
                      })),
              const Spacer(),
              Container(
                  width: double.infinity,
                  margin: const EdgeInsets.all(30),
                  child: RoundedButton(
                      child: const Text("Devam et"),
                      onPressed: () => AutoRouter.of(context).navigate(
                          RegisterStepThreeScreenRoute(
                              allowedChatMethods: selectedItems))))
            ],
          )),
    );
  }
}
