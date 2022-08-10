import 'package:bind/model/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/assets/utils.dart';
import '../model/message_model.dart';

class FirebaseApi {
//uploading messasge to firestore
  static Future uploadMessage({
    required String recieverId,
    required String message,
    required String currentUserId,
    required String recieverAvatarUrl,
    required String recieverUsername,
  }) async {
    //adding datas to CurrentUser database
    final refMessage =  FirebaseFirestore.instance
        .collection('chats').doc(currentUserId).collection('messages').doc(recieverId).collection('chats');

    final newMessage = Message(
      senderId: currentUserId,
      recieverId: recieverId,
      recieverAvatarUrl: recieverAvatarUrl,
      recieverUsername: recieverUsername,
      message: message,
      createdAt: DateTime.now(),
    );
    await refMessage.add(newMessage.toJson()).then((value) {
    final cRef=  FirebaseFirestore.instance.collection('chats').doc(currentUserId).collection('messages').doc(recieverId);
    cRef.set({'lastMessage':message});
    });
    //adding datas to reciever's data base

    final recieverRef=FirebaseFirestore.instance
    .collection('chats').doc(recieverId).collection('messages').doc(currentUserId).collection('chats');
    recieverRef.add(newMessage.toJson()).then((value) => {
    
     FirebaseFirestore.instance.collection('chats').doc(recieverId).collection('messages').doc(currentUserId).set({
      'lastMessage':message
     })
 


    });
    //reciever time updated
    final refUsers = FirebaseFirestore.instance.collection('users');
    await refUsers
        .doc(recieverId)
        .update({UserField.lastMessageTime: DateTime.now()});
  }

//fetching messages
  static Stream<QuerySnapshot<Map<String, dynamic>>> getMessages(
          String idUser) =>
      FirebaseFirestore.instance
          .collection('chats/$idUser/messages')
          .orderBy(MessageField.createdAt, descending: true)
          .snapshots();
}
