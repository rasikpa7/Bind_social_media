import 'package:bind/view/screens/feedScreen/widgets/user_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final List people=[
'salsal','jafer',
'kiran','karthik',
'razik'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // backgroundColor:Colors.transparent ,
        elevation: 0,
        title: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bind',style: TextStyle(letterSpacing: 4,
              color: Colors.black),),
            Icon(Icons.message_outlined),
          ],
        ),

      ),

      body:
      StreamBuilder(stream: FirebaseFirestore.instance.collection('posts').snapshots(),
      builder:(context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){

        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        return ListView.builder(itemCount: snapshot.data!.docs.length,
          itemBuilder: ((context, index) {
          return UserPosts(snap: snapshot.data!.docs[index].data(), );
        }));



      },
      )
   

    );
  }
}