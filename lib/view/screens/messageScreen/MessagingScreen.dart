import 'package:bind/provider/user_provider.dart';
import 'package:bind/view/screens/messageScreen/widget/chatScreen.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

import '../../../model/user.dart';

class MessagesScreen extends StatelessWidget {
  MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
        ),
      ),
      body: Column(
        children: [
          Container(
              padding: EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              height: 100,
              child: ChatHeaderWidjet()),
          Expanded(
              child: Container(
            decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(35),
                    topRight: Radius.circular(35))),
          ))
        ],
      ),
    );
  }
}

class ChatHeaderWidjet extends StatelessWidget {
  const ChatHeaderWidjet({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Currentuser= Provider.of<UserProvider>(context).getUser;
    return StreamBuilder(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: ((context,
        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
              snapshot) {
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
          physics: BouncingScrollPhysics(),
          cacheExtent: 100000,
            scrollDirection: Axis.horizontal,
            itemCount: snapshot.data!.docs.length,
            itemBuilder: ((context, index) {
              return Container(
                margin: EdgeInsets.all(5.0),
                child:
                 InkWell(
                 
                  
                  onTap: (){
                    Navigator.of(context).push(MaterialPageRoute(builder: (context)=>
                    ChatScreen(snap:  User.fromSnap(snapshot.data!.docs[index]),)));

                  },

                   child: 
                   snapshot.data!.docs[index]['uid']==Currentuser!.uid?
                   SizedBox():
                   CircleAvatar(
                        backgroundColor: Colors.grey[400],
                    radius: 30,
                    backgroundImage: CachedNetworkImageProvider(snapshot.data!.docs[index]['photoUrl']),
                    child: Text(snapshot.data!.docs[index]['username'],style: TextStyle(
                      color: Colors.white,fontSize: 15,fontWeight: FontWeight.bold
                    ),),
                     
                       
                                
                                 ),
                 ),
              );
            }));
      }),
    );
  }
}
