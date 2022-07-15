import 'package:bind/view/screens/screenwidgets/explore_grid.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(backgroundColor: Colors.blue,
  
      title: Text('Rzk.404',style: TextStyle(color: Colors.black),),
      actions: [
      IconButton(onPressed: (){
         FirebaseAuth.instance.signOut();
      }, icon: Icon(Icons.remove))
      ],
    ),
      body: SafeArea(
        child: Column(
          children: [
           
         
             profilepic(),

             Expanded(child: 
             ExploreGrid())


          
           
        
           
        
          ],
        ),
      ),
    );
   
    
  }
}

class profilepic extends StatelessWidget {
  const profilepic({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
           backgroundImage: NetworkImage('https://images.pexels.com/photos/792326/pexels-photo-792326.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1'),
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
           Text('150',style: TextStyle(fontSize: 18),),
           
           Text('210',style: TextStyle(fontSize: 18),),
          
         ],
        
       )
     ],
    ),
    
            );
  }
}