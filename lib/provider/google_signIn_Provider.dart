
import 'package:bind/model/user.dart' as model;
import 'package:bind/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInProvider with ChangeNotifier{
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final googleSignIn=GoogleSignIn();

  GoogleSignInAccount ? _user;

  GoogleSignInAccount get user => _user!;
  
  bool isLoading=false;

  void isLoadingValue(bool value) {
    isLoading = value;
    notifyListeners();
  }

  Future <String>googleLogIN(BuildContext context)async{
     isLoading=true;
     notifyListeners();
    try{


       final googleUser=await googleSignIn.signIn();
    if(googleUser==null) {return 'No user found';}
    _user=googleUser;

    final googleAuth = await googleUser.authentication;

    OAuthCredential credential =  GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

    final googleUsercred=await FirebaseAuth.instance.signInWithCredential(credential);
    
    isLoading=false;
     notifyListeners();
    

    return 'success';

    }catch(e){
     
  showSnackBarr(e.toString(), context);
    return 'something went wrong';
    }

  }

  Future  <String>googleSignUP(BuildContext context)async{

    try {
  final googleUser=await googleSignIn.signIn();
    if(googleUser==null){
return'NO user found';
    } 
    _user=googleUser;

    final googleAuth = await googleUser.authentication;

    OAuthCredential credential =  GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken
    );

//user register with credentials
     final googleUsercred=await FirebaseAuth.instance.signInWithCredential(credential);
     
  //get all deatails
   model.User user = model.User(
          username: googleUsercred.user!.displayName,
          uid: googleUsercred.user!.uid,
          email: googleUsercred.user!.email,
          bio: 'add bio',
          photoUrl: googleUsercred.user!.photoURL,
          following: [],
          followers: [],
          lastMessageTime:  DateTime.now()
        );
    
    //adding all user data to database
     await _firestore
            .collection('users')
            .doc(googleUsercred.user!.uid)
            .set(user.toJson());


   notifyListeners();  
   
  return 'success';

    }catch(e){
      showSnackBarr(e.toString(), context);
     
     return e.toString();
    }
  }
}