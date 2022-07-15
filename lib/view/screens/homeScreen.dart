import 'package:bind/view/screens/screenwidgets/user_post.dart';
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
            Icon(Icons.message),
          ],
        ),

      ),

      body: ListView.builder(itemCount: people.length,
        itemBuilder: (context, index) =>
      UserPosts(name: people[index],) ),

    );
  }
}