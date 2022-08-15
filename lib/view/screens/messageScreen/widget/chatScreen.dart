
import 'package:bind/resources/firebase_message_api.dart';
import 'package:bind/model/utils/utils.dart';
import 'package:bind/view/screens/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import '../../../../controller/user_provider.dart';
import '../../../../model/user.dart';
import 'messageSentTextField.dart';
import 'messageView.dart';

class ChatScreen extends StatelessWidget {
  User snap;
    ChatScreen({Key? key, required this.snap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
  final user= Provider.of<UserProvider>(context).getUser;

    
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.black,
  
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Profile(uid: snap.uid);
              },));
            },
              child: Text(snap.username!.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w400),)),
              SizedBox(height: 2.h,),
           snap.status=='online'? Row(children: [
              Text(' Online',style: TextStyle(fontSize: 13.sp),),
              SizedBox(width:4.w),
              CircleAvatar(radius: 5.r,
                backgroundColor: Colors.green
              ,)
            ],):Row(children: [
              Text('Offline',style: TextStyle(fontSize: 13.sp),),
              SizedBox(width:4.w),
              CircleAvatar(radius: 5.r,
                backgroundColor: Colors.red
              ,)
            ],)
          ],
        ),),

        body: Column(
          children: [
            //message view
            Expanded(child: 
            Container(
            
            child: 
            MessageViewWidget(idUser: snap.uid),
            
            )),
            //messaage sending field
            Padding(
              padding:  EdgeInsets.all(8.0.r),
              child: SentNewMessageTextField(snap: snap,currentUser: user),
            ),
          ],
        ),
    );
  }
}

