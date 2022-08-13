import 'dart:developer';
import 'dart:typed_data';

import 'package:bind/model/user.dart' as model;
import 'package:bind/resources/auth_methods.dart';
import 'package:bind/model/utils/utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/storage_methods.dart';

class UserProvider with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  model.User? _user;

  final AuthMethods _authMethods = AuthMethods();

  Uint8List? file;

  bool isLoading = false;

  Uint8List? image;

void addnulltoImageFile(){
  file=null;
}
  void addImageUint8List(Uint8List image8) {
    image = image8;
    notifyListeners();
  }

  void isLoadingValue(bool value) {
    isLoading = value;
    notifyListeners();
  }

//edit profile pic
  Future<void> editProfilePicPmethod(
      {required BuildContext context, required Uint8List image}) async {
    try {
      String photoUrl = await StorageMethods()
          .uploadImageToStorage('profilePics', image, false);

      await _firestore
          .collection('users')
          .doc(_auth.currentUser!.uid)
          .update({'photoUrl': photoUrl});
    } catch (e) {
      showSnackBarr(e.toString(), context);
    }
  }

  Future editBio (BuildContext context,
    String bio)async{

    try{
      _firestore.collection('users').doc(_auth.currentUser!.uid).update({
          'bio':bio
      });

    }catch(e){

      showSnackBarr(e.toString(), context);
    }


  }

  Future<void> selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload profile pic'),
            children: [
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Take a photo'),
                onPressed: () async {
                  Navigator.of(context).pop();

                  file = await pickImage(ImageSource.camera);

                  notifyListeners();
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Choose from gallery'),
                onPressed: () async {
                  Navigator.of(context).pop();
                  file = await pickImage(ImageSource.gallery);

                  notifyListeners();
                },
              ),
              SimpleDialogOption(
                padding: EdgeInsets.all(20),
                child: const Text('Cancel'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        });
  }

  model.User? get getUser => _user;

  Future<void> refreshUser() async {
    print('villichuuuuuuu');
    _user = await _authMethods.getUserDetails();

    // log(_user!.photoUrl.toString());

    // // log('message:$user');
    //  debugPrint('testcheck: $_user');
    notifyListeners();
  }
}
