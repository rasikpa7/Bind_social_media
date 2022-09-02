import 'dart:ui';

import 'package:bind/model/user.dart';

import 'package:bind/view/screens/messageScreen/widget/chatScreen.dart';
import 'package:bind/view/widgets/ImageAlertView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';

class ChatHeaderWidjet extends StatelessWidget {
  const ChatHeaderWidjet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Currentuser = Provider.of<UserProvider>(context).getUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: ((context,
          AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (!snapshot.hasData) {
          const Center(
            child: Text('No users'),
          );
        } else if (snapshot.hasError) {
          const Center(
            child: Text('Something wentwrong'),
          );
        }
        return ListView.builder(
            physics:const  BouncingScrollPhysics(),
            cacheExtent: 100000,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: EdgeInsets.all(5.0.r),
                child: InkWell(
                  onLongPress: (){
                          showDialog(context: context, builder: (builder){
                                    return ImageAlertView(isProfile: true,imageUrl:snapshot.data!.docs[index]['photoUrl'],);
                                  });
                  },
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ChatScreen(
                                snap: User.fromSnap(snapshot.data!.docs[index]),
                              )));
                    },
                    child: snapshot.data!.docs[index]['uid'] == Currentuser!.uid
                        ? const SizedBox()
                        : 
                         
                            CircleAvatar(
                                backgroundColor: Colors.grey[400],
                                radius: 30.r,
                                backgroundImage: CachedNetworkImageProvider(
                                    snapshot.data!.docs[index]['photoUrl']),
                               child:  Text(
                                  snapshot.data!.docs[index]['username'],textAlign: TextAlign.center,
                                  overflow: TextOverflow.ellipsis,
                                  style:  TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.sp,
                                      fontWeight: FontWeight.bold,
                                      ),
                                ),
                              ),
                             
                         
                        ),
              );
            }));
      }),
    );
  }
}
