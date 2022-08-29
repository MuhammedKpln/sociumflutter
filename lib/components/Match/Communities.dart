import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flutter/material.dart';
import 'package:scflutter/components/GradientText.dart';
import 'package:scflutter/utils/avatar.dart';
import 'package:scflutter/utils/palette.dart';

class CommunitiesTab extends StatefulWidget {
  const CommunitiesTab({Key? key}) : super(key: key);

  @override
  State<CommunitiesTab> createState() => _CommunitiesTabState();
}

Widget Post({required String title, required String categoryName, image}) {
  return Container(
    margin: const EdgeInsets.only(bottom: 5),
    padding: const EdgeInsets.all(10),
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          colors: [Colors.grey.shade900, Colors.black26],
        )),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: image != null
                ? Image.network(generateAvatarUrl(image),
                    width: 70, height: 70, fit: BoxFit.fill)
                : Container(
                    width: 70,
                    height: 70,
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: [
                      ColorPalette.primary,
                      ColorPalette.primary.withOpacity(0.7)
                    ])),
                    child: Center(
                        child: Text(
                      title.characters.first,
                      style: const TextStyle(color: Colors.white),
                    )),
                  ),
          ),
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(title),
                      const Icon(
                        EvaIcons.globe,
                        size: 17,
                      )
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(5),
                        decoration: BoxDecoration(
                            color: ColorPalette.surface,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(categoryName),
                      ),
                      Row(
                        children: const [
                          Text("3232"),
                          Icon(
                            EvaIcons.people,
                            size: 17,
                          )
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ]),
  );
}

class _CommunitiesTabState extends State<CommunitiesTab> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientText("Topluluklar",
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: Theme.of(context).textTheme.titleLarge?.fontSize)),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20),
            child: Text(
              "Yeni topluluklar keşfedin",
              style: Theme.of(context)
                  .textTheme
                  .labelLarge
                  ?.apply(color: Colors.grey.shade400),
            ),
          ),
          // Expanded(
          //   child: Query(
          //       options: QueryOptions(
          //           document: FetchPostsQuery(
          //                   variables:
          //                       FetchPostsArguments(limit: 15, offset: 0))
          //               .document),
          //       builder: (QueryResult result,
          //           {VoidCallback? refetch, FetchMore? fetchMore}) {
          //         if (result.isLoading) {
          //           return const Center(child: CircularProgressIndicator());
          //         }

          //         final data = FetchPosts$Query.fromJson(result.data!);

          //         return ListView.builder(
          //           itemBuilder: ((context, index) {
          //             final item = data.posts[index];

          //             return Post(
          //                 title: item.content,
          //                 categoryName: item.category.name);
          //           }),
          //           itemCount: result.data?.length,
          //         );
          //       }),
          // )
        ],
      ),
    );
  }
}
