import 'package:bind/view/screens/feedScreen/widgets/user_post.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserPostViewScreen extends StatelessWidget {
  final uid;
  const UserPostViewScreen({Key? key, this.uid}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(title:  const Text('Posts')),

      body: StreamBuilder (stream: FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: uid).
      snapshots(),
     
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){
       if(snapshot.connectionState==ConnectionState.waiting){
        return const Center(
          child: CircularProgressIndicator(),
        );
       }else if(snapshot.data!.docs.isEmpty){
        return const Center(
          child: Text('No photo'),
        );
       }
       
       
       return ListView.builder(itemCount: snapshot.data!.docs.length,
        itemBuilder: (context,index){
                return UserPosts(snap: snapshot.data!.docs[index].data());
       });
       
      },
    ));

    
  }
}