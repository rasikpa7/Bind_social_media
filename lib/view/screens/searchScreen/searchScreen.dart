import 'package:bind/view/screens/profile/profile.dart';
import 'package:bind/view/screens/searchScreen/widgets/explore_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

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
                                child: ListTile(
                                  leading: CircleAvatar(
                                      backgroundColor: Colors.redAccent,
                                      radius: 30,
                                      backgroundImage: snapshot
                                                  .data!.docs.length ==
                                              0
                                          ? NetworkImage(
                                              'https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')
                                          : NetworkImage(snapshot
                                              .data!.docs[index]['photoUrl'])),
                                  title: Text(
                                      snapshot.data!.docs[index]['username']),
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
                            
                              (context, index) => ExploreCard(
                                    imageUrl: snapshot.data!.docs[index]
                                        ['postUrl'],
                                  )),
                        )

                      //  GridView.builder(
                      //     itemCount: snapshot.data!.docs.length,
                      //     gridDelegate:
                      //         const SliverGridDelegateWithFixedCrossAxisCount(
                      //       crossAxisCount: 3,
                      //     ),
                      //     itemBuilder: (context, index) {
                      //       return ExploreCard(
                      //         imageUrl: snapshot.data!.docs[index]['postUrl'],
                      //       );
                      //     })
                      : const Center(
                          child: Text('nothing found'),
                        );
                },
              ));
  }
}
