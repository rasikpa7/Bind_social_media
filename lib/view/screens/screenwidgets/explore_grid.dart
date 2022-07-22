import 'package:bind/model/user.dart'as model;
import 'package:bind/provider/user_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ExploreGrid extends StatelessWidget {
  const ExploreGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  final model.User? user =Provider.of<UserProvider>(context).getUser;

    
    return

    StreamBuilder(stream: FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo: user!.uid).snapshots(),
    builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){

          if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.hasError){
          return const Center(
            child: Text('Something went wrong'),
          );
        }
        else if(snapshot.data!.docs.length==null){
          return Text('Something went wrong');
        }

        return snapshot.data!.docs==null?
        const Center(
          child: Text('No photos'),
        ):
             GridView.builder(
              itemCount: snapshot.data!.docs.length,
  
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3
    ), itemBuilder: (context,index){
return Padding(
  padding: const EdgeInsets.all(4.0),
  child:   Card(
    child: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),
                      image: DecorationImage(
        image: NetworkImage(snapshot.data!.docs[index].data()['postUrl']),
        fit: BoxFit.cover),
      ),
    
      
    
    ),
  ),
);

    });


     });



  }
}