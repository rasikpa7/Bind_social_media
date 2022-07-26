import 'package:bind/view/screens/screenwidgets/explore_grid.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key? key}) : super(key: key);

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  bool isShowUser=false;

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: TextFormField(
          controller: searchController,
          decoration: InputDecoration(
            labelText: 'Search user',
          ),
          onFieldSubmitted: (String _) {
            print(_);
            setState(() {
              isShowUser=true;
            });
          },
        ),
      ),
      body:  isShowUser? FutureBuilder(
        future: FirebaseFirestore.instance
            .collection('users')
            .where('username', isEqualTo: searchController.text)
            .get(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          else if(snapshot.data!.docs==null){
                return const Center(child: Text('Nothing found'));
          }
       return snapshot.data!.docs.isNotEmpty?
           ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder:(context, index) {
            return Padding(
              padding: const EdgeInsets.all(5.0),
              child: ListTile(
                leading: CircleAvatar(
                  backgroundColor: Colors.redAccent,
                  radius: 30,
                  backgroundImage:snapshot.data!.docs.length==0?NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg')   :
                   NetworkImage(snapshot.data!.docs[index]['photoUrl']) 
               
                ),
                title: Text(snapshot.data!.docs[index]['username']),
              ),
            );
          }):Center(child: Text('User Not Found'));
          
        },
      ):Center(
        child: Text('posts'),
      )
    );
  }
}
