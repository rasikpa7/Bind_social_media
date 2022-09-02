
import 'package:bind/view/screens/messageScreen/widget/chatHeadWidget.dart';
import 'package:bind/view/screens/messageScreen/widget/chatScreen.dart';
import 'package:bind/view/widgets/ImageAlertView.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../controller/user_provider.dart';
import '../../../model/user.dart' as model;

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Messages',
        ),
      ),
      body: Column(
        children: [
          //chat head view
          Container(
              padding: EdgeInsets.only(
                left: 5.w,
                right: 5.w,
              ),
              height: 100,
              child: const ChatHeaderWidjet()),

          //recently texted list view
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 10.h),
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5.r),
                    topRight: Radius.circular(5.r))),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').orderBy('lastMessageTime',descending: true).snapshots(),
              builder: (context,
                  AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
                      if(snapshot.connectionState==ConnectionState.waiting){
                        return  const Center(
                          child: CircularProgressIndicator(),
                        );
                      } 
                      else if(!snapshot.hasData){
                        return  const Center(
                          child: CircularProgressIndicator(),
                        );

                      }
                return ListView.builder(
                  physics: BouncingScrollPhysics(),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      
                     
                      if (snapshot.data!.docs[index]['uid'] ==
                          currentUser!.uid) {
                        return const SizedBox();
                      }
                     

                      return Padding(
                          padding:  EdgeInsets.all(3.5.r),
                          child: InkWell(
                            onLongPress: (){
                              showDialog(context: context, builder: (builder){
                                    return ImageAlertView(isProfile: true,imageUrl:snapshot.data!.docs[index]['photoUrl'],);
                                  });
                              
                            },
                            onTap: () {

                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    ChatScreen(snap: model. User.fromSnap(snapshot.data!.docs[index]),)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(18.r)),
                              child: Padding(
                                padding:  EdgeInsets.all(5.5.r),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 25.r,
                                      backgroundColor: Colors.grey[400],
                                      backgroundImage: CachedNetworkImageProvider(
                                          snapshot.data!.docs[index]
                                              ['photoUrl'])),
                                  title: Text(
                                    snapshot.data!.docs[index]['username'],overflow: TextOverflow.ellipsis,maxLines: 8,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing:   CircleAvatar(radius: 5.r,
                                    backgroundColor:snapshot.data!.docs[index]['status']=='online'? Colors.green:Colors.red)
                                ),
                              ),
                            ),
                          ));
                    });
              },
            ),
          ))
        ],
      ),
    );
  }
}
