import 'package:bind/model/user.dart';
import 'package:bind/provider/user_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:provider/provider.dart';

class CommentCard extends StatefulWidget {
  const CommentCard({Key? key}) : super(key: key);

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final User? user=Provider.of<UserProvider>(context).getUser;
  
   return Container(
    padding: const EdgeInsets.symmetric(
      vertical: 18,
      horizontal: 
      16,

    ),
    child: Row(
      children: [
         CircleAvatar(
          backgroundImage:  NetworkImage(user!.photoUrl!),
          radius: 18,
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(left:8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                RichText(
                  text: 
                 TextSpan(children: [
                  TextSpan(
                    text: 'Username',style: const TextStyle(fontWeight: FontWeight.bold,color: Colors.black,
                    
                    )
                  ),
                  const TextSpan(
                    text: '   Some description',style: TextStyle(color: Colors.black,
                    
                    )
                  )
                ])
                ),
                 const Text('20/12/2000',style: TextStyle(fontWeight: FontWeight.w300),)
              ],
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(8.0),
          child: const Icon(Icons.favorite,size: 18,),
        )
      ],
    ),

   );
    
  }
}