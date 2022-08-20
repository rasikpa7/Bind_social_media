import 'package:bind/view/screens/profile/widgets/userPostsViewScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../widgets/ImageAlertView.dart';

class UserPostGrid extends StatelessWidget {
  final useruid;
  UserPostGrid({Key? key, required this.useruid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // final model.User? user =Provider.of<U
    // serProvider>(context).getUser;

    return StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .where('uid', isEqualTo: useruid)
            .snapshots(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if ( snapshot.connectionState == ConnectionState.waiting ) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('something went wrong'),
            );
          } else if (snapshot.data?.docs == null) {

            return const Text('is empty');

          }

          return snapshot.data!.docs.isEmpty
              ? const Center(
                  child: Text('No photos'),
                )
              : GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: snapshot.data!.docs.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3),
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: (() =>
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UserPostViewScreen(
                                    uid: useruid,
                                  )))),
                      onLongPress: () {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return ImageAlertView(
                                isProfile: false,
                                imageUrl: snapshot.data!.docs[index]
                                    .data()['postUrl'],
                              );
                            });
                      },
                      child: Padding(
                        padding:  EdgeInsets.all(4.0.r),
                        child: Card(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5.r),
                            child: CachedNetworkImage(
                              height: 400.h,
                              imageUrl:
                                  snapshot.data!.docs[index].data()['postUrl'],
                              imageBuilder: (context, imageProvider) =>
                                  Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: imageProvider,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              placeholder: (context, url) => Container(
                                decoration: const BoxDecoration(
                                    image: DecorationImage(
                                        image: AssetImage(
                                            'lib/model/assets/placeholder_for_homepost.jpg'),
                                        fit: BoxFit.cover)),
                              ),
                              errorWidget: (context, url, error) =>  Icon(
                                Icons.error,
                                size: 30.sp,
                                color: Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  });
        });
  }
}
