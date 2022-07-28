
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
class UserPostGrid extends StatelessWidget {
  final useruid;
   UserPostGrid({Key? key,  required this.useruid}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
  // final model.User? user =Provider.of<U
  // serProvider>(context).getUser;

    
    return

    StreamBuilder(stream:  FirebaseFirestore.instance.collection('posts').where('uid',isEqualTo:useruid ).
     snapshots(),
    builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){

          if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.hasError){
          print('checkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk${snapshot.data?.docs[0]['postUrl']}');
          return  Center(
            child: Text('something went wrong'),
          );
        }
        else if(snapshot.data?.docs==null){
          return const Text('is empty');
        }

        return snapshot.data!.docs.isEmpty?
        const Center(
          child: Text('No photos'),
        ):
             GridView.builder(
              itemCount: snapshot.data!.docs.length,
  
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
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