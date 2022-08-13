import 'package:flutter/material.dart';

class ImageAlertView extends StatelessWidget {
  final imageUrl;
  bool isProfile;
   ImageAlertView({

    Key? key,
    required this.isProfile, this.imageUrl
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(backgroundColor: Colors.transparent,
      content: isProfile?
      CircleAvatar(radius: 130,
      backgroundImage: NetworkImage(imageUrl),):
      Container(
        height: 300,width: 150,
        decoration: BoxDecoration(image: DecorationImage(image:  NetworkImage(imageUrl),
            fit: BoxFit.cover)),
      ),
    );
  }
}