
import 'package:bind/view/screens/messageScreen/widget/chatHeadWidget.dart';
import 'package:bind/view/screens/messageScreen/widget/chatScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
        title: Text(
          'Messages',
        ),
      ),
      body: Column(
        children: [
          //chat head view
          Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              height: 100,
              child: ChatHeaderWidjet()),

          //recently texted list view
          Expanded(
              child: Container(
            padding: EdgeInsets.only(top: 10),
            decoration: BoxDecoration(
                color: Colors.grey[500],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
            child: StreamBuilder(
              stream:
                  FirebaseFirestore.instance.collection('users').orderBy('lastMessageTime',descending: false).snapshots(),
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
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      
                     
                      if (snapshot.data!.docs[index]['uid'] ==
                          currentUser!.uid) {
                        return const SizedBox();
                      }
                     

                      return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: InkWell(
                            onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    ChatScreen(snap: model. User.fromSnap(snapshot.data!.docs[index]),)));
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(18)),
                              child: Padding(
                                padding: const EdgeInsets.all(5.5),
                                child: ListTile(
                                  leading: CircleAvatar(
                                      radius: 25,
                                      backgroundImage: CachedNetworkImageProvider(
                                          snapshot.data!.docs[index]
                                              ['photoUrl'])),
                                  title: Text(
                                    snapshot.data!.docs[index]['username'],
                                    style: TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  trailing: CircleAvatar(radius: 5,
                                    backgroundColor: Colors.green,)
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
