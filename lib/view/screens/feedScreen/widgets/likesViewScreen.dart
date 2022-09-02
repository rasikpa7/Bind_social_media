import 'dart:developer';

import 'package:bind/model/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LikesViewScreen extends StatelessWidget {
  final postId;
  LikesViewScreen({Key? key, required this.postId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 350.h,
        color: const Color(0xFF737373),
        child: Container(
            padding: EdgeInsets.all(15.r),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15.0.r),
                    topRight: Radius.circular(15.0.r))),
            child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('posts')
                    .doc(postId)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return  Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                
                  else if(snapshot.data==null){
                     return  const Center(
                      child: CircularProgressIndicator(),);
                  }
                
                  List? likesList =  snapshot.data?.data()!['likes'];
                //  log(likesList!.length.toString());
                 !snapshot.hasData?
                 Center(child: Text('no data'),):Center(child: Text('loading'),);

                  return ListView.separated(separatorBuilder: (context, index) {
                    return Divider();
                  },
                    itemCount:
                     likesList!.length,
                    itemBuilder: (context, index) {
                      return StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection('users')
                            .doc(likesList[index])
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<
                                    DocumentSnapshot<Map<String, dynamic>>>
                                snapshot) {
                          // final likedUsers = User.fromSnap(snapshot.data);
                          // log(likedUsers.toString())
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                          else if (!snapshot.hasData) {
                         return   const Center(
                              child: Text('no data'),
                            );
                          }
                          else if(snapshot.data==null){
                            return const Center(child: Text('Loading...'),);
                          }

                          return 
                         
                          ListTile(
                            leading: Container(
                              width: 40.w,
                              height: 40.h,
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                      image: CachedNetworkImageProvider(
                                         snapshot.data!.data()!['photoUrl']),
                                      fit: BoxFit.cover),
                                  shape: BoxShape.circle),
                            ),
                            title: Text(snapshot.data!.data()!['username'])
                          );
                        },
                      );
                    },
                  );
                })));
  }
}
