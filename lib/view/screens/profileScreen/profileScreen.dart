import 'package:bind/model/user.dart'as Usermodel;
import 'package:bind/provider/user_provider.dart';
import 'package:bind/view/screens/profileScreen/widgets/profileImage.dart';
import 'package:bind/view/screens/screenwidgets/explore_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
      final Usermodel.User? user =Provider.of<UserProvider>(context).getUser;
    return Scaffold(appBar: AppBar(backgroundColor: Colors.blue,
  
      title: Text(user!.username.toString(),style: TextStyle(color: Colors.black),),
      actions: [
      IconButton(onPressed: (){
         FirebaseAuth.instance.signOut();
      }, icon: Icon(Icons.remove))
      ],
    ),
      body: SafeArea(
        child: Column(
          children: [
           
         
             profilepic(),

             Expanded(child: 
             ExploreGrid())


          
           
        
           
        
          ],
        ),
      ),
    );
   
    
  }
}
