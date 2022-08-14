
import 'package:bind/resources/firebase_message_api.dart';
import 'package:bind/model/utils/utils.dart';
import 'package:bind/view/screens/profile/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      actions: [

        IconButton(onPressed: ()async{
           showDialog(
                              context: context,
                              builder: (ctx) => AlertDialog(
                                    title: Text('Clear Chat History'),
                                    content:
                                        Text('Are you sure want to clear chat ? '),
                                    actions: [
                                      ElevatedButton(
                                          onPressed: () async {
                                            await FirebaseApi().clearMessages(currentuserId: user!.uid!, reciever: snap.uid!);
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text('YES')),

                                          ElevatedButton(onPressed: (){
                                            Navigator.of(context).pop();
                                          }, child: const Text('NO'))
                                    ],
                                  ));

        }, icon:const  Icon(Icons.delete_forever))
     
      ],
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
          
            InkWell(onTap: (){
              Navigator.of(context).push(MaterialPageRoute(builder: (context) {
                return Profile(uid: snap.uid);
              },));
            },
              child: Text(snap.username!.toUpperCase(),style: TextStyle(fontWeight: FontWeight.w400),)),
              SizedBox(height: 2,),
            Row(children: const[
              Text(' Online',style: TextStyle(fontSize: 13),),
              SizedBox(width:4),
              CircleAvatar(radius: 5,
                backgroundColor: Colors.green
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
              padding: const EdgeInsets.all(8.0),
              child: SentNewMessageTextField(snap: snap,currentUser: user),
            ),
          ],
        ),
    );
  }
}

