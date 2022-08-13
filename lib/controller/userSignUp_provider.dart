import 'dart:typed_data';

import 'package:bind/model/utils/utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../resources/auth_methods.dart';

class SignUpProvider with ChangeNotifier {
  Uint8List? file;
   bool isLoading=false;
  void clearImageFile() {
    file = null;
  }

  // Future<String> signUpUser({
  //   required TextEditingController email,
  //   required TextEditingController password,
  //   required TextEditingController username,
  //   required TextEditingController bio,
  //   // required Uint8List imageFile,
  // }) async {
  //   isLoading=true;
  //   notifyListeners();
  //   String res = await AuthMethods().signUpUser(
       
  //       email: email.text.trim(),
  //       password: password.text.trim(),
  //       username: username.text.trim(),
  //       bio: bio.text.trim(),
  //       file: file!);
  // Future.delayed(Duration(seconds: 5));
  //       isLoading=false;
  //       notifyListeners();

  //       return res;

  
  
  // }

  Future<void> selectImage(BuildContext context) async {
    return showDialog(
        context: context,
        builder: (context) {
          return SimpleDialog(
            title: const Text('Upload profile pic'),
            children: [
              // SimpleDialogOption(
              //   padding: EdgeInsets.all(20),
              //   child: const Text('Take a photo'),
              //   onPressed: () async {
              //     Navigator.of(context).pop();

              //     file = await pickImage(ImageSource.camera);

              //     notifyListeners();
              //   },
              // ),
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
}
