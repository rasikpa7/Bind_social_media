import 'package:bind/provider/user_provider.dart';
import 'package:bind/view/screens/feedScreen/widgets/user_post.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
   HomeScreen({Key? key}) : super(key: key);
  final List people=[
'salsal','jafer',
'kiran','karthik',
'razik'
  ];
  @override
  Widget build(BuildContext context) {
    final currentUser=Provider.of<UserProvider>(context).getUser;
    return Scaffold(
      backgroundColor: Colors.black.withOpacity(0.8),
      appBar: AppBar(
        // backgroundColor:Colors.transparent ,
        elevation: 0,
        title:   Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Bind',style:GoogleFonts.dancingScript(
                  textStyle: const TextStyle( 
                    fontSize: 34,
                    fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                  color: Colors.white)
                ),),
           

             Text(
              currentUser!.username!,style:GoogleFonts.dancingScript(
                  textStyle: const 
                  TextStyle(
                    fontSize: 34,
                    // fontWeight: FontWeight.bold,
                  letterSpacing: 0,
                  color: Colors.white)
                ),),

            
          ],
        ),
            centerTitle: true,

      ),

      body:
      StreamBuilder(stream: FirebaseFirestore.instance.collection('posts').orderBy('datePublished',descending: true).snapshots(),
      builder:(context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>snapshot){

        if(snapshot.connectionState==ConnectionState.none){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }else if(snapshot.data==null){
          return const Center(
            child: CircularProgressIndicator());
        }
        if(snapshot.connectionState==ConnectionState.waiting){
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        else if(snapshot.data!.docs.isEmpty){
            return const Center(
              child: Text('no recent posts',style: TextStyle(color: Colors.white),),
            );
        }
        

        return ListView.builder(itemCount: snapshot.data!.docs.length,
        physics: BouncingScrollPhysics(),
          itemBuilder: ((context, index) {
          return 
        
           UserPosts(snap: snapshot.data!.docs[index].data(), );
        }));



      },
      )
   

    );
  }
}