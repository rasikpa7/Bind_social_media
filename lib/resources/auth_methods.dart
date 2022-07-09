import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AuthMethods {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore=FirebaseFirestore.instance;

  //Sign up user 
 Future<String> signUpUser(
      {
       required String email,
       required String password,
       required String username,
       required String bio,
       required Uint8List file
      })async {
String res='Some error occured';
try{
  if(email.isEmpty||password.isEmpty||username.isEmpty||bio.isEmpty||file!=null){
  UserCredential cred= await _auth.createUserWithEmailAndPassword(email: email, password: password);
 await _firestore.collection('users').doc(cred.user!.uid).set({
'username':username,
'uid':cred.user!.uid,
'email':email,
'bio':bio,
'followers':[],
'following':[],
  });

  res='success';

  }

}catch(err){
  res=err.toString();
}
return res;

      }
}
