import 'package:bind/view/screens/profile/profile.dart';
import 'package:bind/view/screens/searchScreen/widgets/explore_grid.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../widgets/ImageAlertView.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowUser = false;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: TextFormField(
            controller: searchController,
            decoration: InputDecoration(
              labelText: 'Search user',
            ),
            onFieldSubmitted: (String _) {
              print(_);
              setState(() {
                isShowUser = true;
              });
            },
          ),
        ),
        body: isShowUser
            ? StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('users')
                    .where('username', isEqualTo: searchController.text)
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.data!.docs == null) {
                    return const Center(child: Text('Nothing found'));
                  }
                  return snapshot.data!.docs.isNotEmpty
                      ? ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(5.0),
                              child: InkWell(
                                onTap: () => Navigator.of(context)
                                    .push(MaterialPageRoute(
                                  builder: (context) => Profile(
                                      uid: snapshot.data!.docs[index]['uid']),
                                )),
                                child: Container(
                                  decoration: BoxDecoration(
                                      color: Colors.blueGrey,
                                      borderRadius: BorderRadius.circular(18)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(7.0),
                                    child: ListTile(
                                      leading: CircleAvatar(
                                          backgroundColor: Colors.grey[500],
                                          radius: 30,
                                          backgroundImage:
                                              CachedNetworkImageProvider(
                                                  snapshot.data!.docs[index]
                                                      ['photoUrl'])),
                                      title: Text(snapshot.data!.docs[index]
                                          ['username']),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          })
                      : const Center(child: Text('User Not Found'));
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return snapshot.data!.docs.isNotEmpty
                      ? GridView.custom(
                          gridDelegate: SliverQuiltedGridDelegate(
                            crossAxisCount: 4,
                            mainAxisSpacing: 2,
                            crossAxisSpacing: 2,
                            repeatPattern: QuiltedGridRepeatPattern.inverted,
                            pattern: [
                              QuiltedGridTile(2, 2),
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 1),
                              QuiltedGridTile(1, 2),
                            ],
                          ),
                          childrenDelegate: SliverChildBuilderDelegate(
                              childCount: snapshot.data!.docs.length,
                              (context, index) => InkWell(
                                onTap: (){
                                  showDialog(context: context, builder: (builder){
                                    return ImageAlertView(isProfile: false,imageUrl: snapshot.data!.docs[index]
                                          ['postUrl'],);
                                  });
                                },
                                child: ExploreCard(
                                      imageUrl: snapshot.data!.docs[index]
                                          ['postUrl'],
                                    ),
                              )),
                        )

                      : const Center(
                          child: Text('nothing found'),
                        );
                },
              ));
  }
}
