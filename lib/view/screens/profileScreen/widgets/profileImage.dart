
import 'package:bind/model/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../provider/user_provider.dart';

class profilepic extends StatelessWidget {
  
  
   profilepic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final User? user =Provider.of<UserProvider>(context).getUser;
    return Container(height: 300,
    child: Column(
     mainAxisAlignment: MainAxisAlignment.center,
     children: [
       Container(
          decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
        boxShadow: [BoxShadow(blurRadius: 10, color: Colors.black, spreadRadius: 5)],),
         child: CircleAvatar(
           radius: 80,
           backgroundImage: NetworkImage(user!.photoUrl.toString()),
         ),
       ),
       SizedBox(height: 25,),
       Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Text('Followers',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           
           Text('Following',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold),),
           
         ],
       ),
         Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
         children: [
           Text(user.followers.length.toString(),style: TextStyle(fontSize: 18),),
           
           Text(user.following.length.toString(),style: TextStyle(fontSize: 18),),
          
         ],
        
       )
     ],
    ),
    
            );
  }
}