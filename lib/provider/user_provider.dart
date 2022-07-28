



import 'dart:developer';
import 'dart:typed_data';

import 'package:bind/model/user.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{
  User? _user;
final AuthMethods _authMethods=AuthMethods();


bool isLoading=false;

 Uint8List? image;

 void addImageUint8List(Uint8List image8){
  image=image8;
  notifyListeners();
 }

void isLoadingValue(bool value){
  isLoading=value;
  notifyListeners();
}



 
User? get getUser =>_user;

Future<void> refreshUser() async {
  print('villichuuuuuuu');
  _user  =await _authMethods.getUserDetails();
 
  // log(_user!.photoUrl.toString());

  // // log('message:$user');
  //  debugPrint('testcheck: $_user');
  notifyListeners();
}

}