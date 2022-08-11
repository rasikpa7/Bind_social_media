
import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/firebase_message_api.dart';
import 'package:bind/utils/utils.dart';
import 'package:bind/view/screens/profile/profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

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

        IconButton(onPressed: (){

        }, icon:const  Icon(Icons.more_vert))
        // InkWell(onTap: (){
        //   showSnackBarr('Coming Soon . . . .', context);
        // },

        //   child: CircleAvatar(child: Icon(Icons.call))),
        // SizedBox(width: 15,),
        //  InkWell(onTap: (){
        //   showSnackBarr('Coming Soon . . . .', context);
        // },
        //    child: CircleAvatar(backgroundColor: Colors.green,
        //     child: Icon(Icons.video_call,color: Colors.white,)),
        //  ),
        //   SizedBox(width: 10,),
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
            Row(children: [
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

