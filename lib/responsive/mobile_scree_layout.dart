import 'package:bind/model/user.dart';
import 'package:bind/provider/user_provider.dart';

import 'package:bind/view/screens/messageScreen/MessagingScreen.dart';

import 'package:bind/view/screens/feedScreen/homeScreen.dart';
import 'package:bind/view/screens/profile/profile.dart';
import 'package:bind/view/screens/profileScreen/profileScreen.dart';
import 'package:bind/view/screens/searchScreen/searchScreen.dart';
import 'package:bind/view/screens/searchScreen/searchScreen.dart';
import 'package:bind/view/screens/uploadScreen/addImageScreen.dart';
import 'package:bind/view/sighUpScreen/signUpScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:bind/model/user.dart'as model;

class MobileScreenLayout extends StatefulWidget {
  const MobileScreenLayout({Key? key}) : super(key: key);

  @override
  State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends State<MobileScreenLayout> {
int _currentIndex=3;

final _pages=[
  HomeScreen(),
  SearchScreen(),
  AddImageScreen(),
  MessagesScreen(),
  Profile(uid: FirebaseAuth.instance.currentUser!.uid,)
];





  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: _pages[_currentIndex],

      bottomNavigationBar: BottomNavigationBar(type:BottomNavigationBarType.fixed ,
        backgroundColor: Colors.black,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        currentIndex: _currentIndex,
        onTap: (value) {
          setState(() {
            _currentIndex=value;
          });
          
        },
   
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home),label: 'Feed',
          backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.search),label: 'Search',
          backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.add_circle),label: 'Add Post',
          backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.chat_bubble),label: 'Messsages',
          backgroundColor: Colors.white),
              BottomNavigationBarItem(icon: Icon(Icons.person),label: 'Profile',
          backgroundColor: Colors.white),

      ]),
    );
    
  }
}