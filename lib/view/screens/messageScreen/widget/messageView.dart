

import 'package:bind/controller/user_provider.dart';
import 'package:bind/model/message_model.dart'as model;

import 'package:bind/resources/firebase_message_api.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'messagebubbleWidget.dart';

class MessageViewWidget extends StatelessWidget {

  

  String? idUser;
   MessageViewWidget({Key? key,this.idUser}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final CurrentUser= Provider.of<UserProvider>(context).getUser;

    return StreamBuilder(
        stream: FirebaseApi.getMessages(idUser: CurrentUser!.uid!, recieverId: idUser!),
      builder: (context,AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
   if(snapshot.connectionState==ConnectionState.waiting){
    return const Center(
      child: CircularProgressIndicator(),
    );
   }
  

      return snapshot.data!.docs.isEmpty?
      buildText('Say Hi...'):ListView.builder(
        physics: const BouncingScrollPhysics(),
        reverse: true,
        itemCount: snapshot.data!.docs.length,
        itemBuilder: (context, index) {
                 
                 final messagessnap=model.Message.fromJson(snapshot.data!.docs[index]);
                 
                 return MessageWidget(message: messagessnap,userImageUrl: snapshot.data!.docs[index]['recieverAvatarUrl'],
                 isMe:messagessnap.senderId==CurrentUser.uid  );
       
      },);

    },);
    
  }
    Widget buildText(String text) => Center(
        child: Text(
          text,
          style: TextStyle(fontSize: 24.sp),
        ),
      );
}