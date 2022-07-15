import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class Activitytile extends StatelessWidget {
   Activitytile({Key? key,required this.name}) : super(key: key);
final String name;
  @override
  Widget build(BuildContext context) {

    return ListTile(

      leading: CircleAvatar(
        backgroundImage:  NetworkImage("https://cdn.pixabay.com/photo/2014/02/27/16/10/tree-276014_960_720.jpg"),
      ),
      title:Row(
        children: [
          Text('${name} ',style: TextStyle(fontWeight: FontWeight.bold),),
          Text('   liked your post'),

        ],
        
      ) ,
      trailing: Icon(Icons.favorite,color: Colors.red,),
      

    );


    
  }
}