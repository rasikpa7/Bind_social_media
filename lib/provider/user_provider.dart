

import 'dart:ffi';

import 'package:bind/model/user.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:flutter/cupertino.dart';

class UserProvider with ChangeNotifier{
  User? _user;
final AuthMethods _authMethods=AuthMethods();



  
User get getUser =>_user!;

Future<void> refreshUser() async {
  User user =await _authMethods.getUserDetails();
  _user=user;
}

}