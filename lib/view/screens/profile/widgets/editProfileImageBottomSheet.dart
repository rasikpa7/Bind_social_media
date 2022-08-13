import 'dart:typed_data';

import 'package:bind/model/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';



class Bottomsheet {
  
  Future EditProfilePic(BuildContext context,

  ) async {
    final user = Provider.of<UserProvider>(context,listen: false);
    //  final image = Provider.of<UserProvider>(context,listen: false).file;
    return showModalBottomSheet(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(20.0))),
        backgroundColor: Colors.white,
        context: context,
        isScrollControlled: true,
        builder: (context) => Container(
              color: const Color(0xFF737373),
              child: Container(
                margin: EdgeInsets.all(10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15)),
                height: 300,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Consumer<UserProvider>(
                          builder: (context, value, child) => 
                         InkWell(
                            onTap: () async {
                            
                                await user.editProfilePicPmethod(
                                    context: context, image: value.file!);
                                    user.addnulltoImageFile();
                                   
                                    Navigator.of(context).pop();
                                    showSnackBarr('Posted  !', context);
                                              
                            },
                            child: Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Post',
                                    style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.blueAccent)),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Consumer<UserProvider>(
                      builder: (context, value, child) => value.file == null
                          ? Center(
                              child: Text('pick some photo'),
                            )
                          : Card(
                              child: Container(
                                height: 200,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(5),
                                    image: DecorationImage(
                                        image: MemoryImage(value.file!),
                                        fit: BoxFit.cover)),
                              ),
                              color: Colors.grey,
                            ),
                    )
                  ],
                ),
              ),
            ));
  }
}
