
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class UserPosts extends StatelessWidget {
   UserPosts({Key? key,required this.name}) : super(key: key);
  final List people=[
'salsal','jafer',
'kiran','karthik',
'razik'
  ];
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
           Row(children: [
               Container(
                
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                   image: DecorationImage(
      image: NetworkImage("https://cdn.pixabay.com/photo/2014/02/27/16/10/tree-276014_960_720.jpg"),
      fit: BoxFit.cover),
                  
                 
                  shape: BoxShape.circle
                ),
                
              ),
              SizedBox(width: 10,),
              Text(name,style: TextStyle(fontWeight: FontWeight.bold),)
           ],),
           Icon(Icons.menu)
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
                          image: DecorationImage(
      image: NetworkImage("https://cdn.pixabay.com/photo/2014/02/27/16/10/tree-276014_960_720.jpg"),
      fit: BoxFit.cover),
          ),
          height: 400,
         
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: const [
                  Icon(Icons.favorite),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal:12 ),
                child: Icon(Icons.chat_bubble_outline),
              ),
              Icon(Icons.share),
                ],
              ),
              Icon(Icons.bookmark),

             

            ],
          ),
          
        ),
         Padding(
           padding: const EdgeInsets.all(8.0),
           child: Row(
                  children: const[
                    Text('Liked by '),
                    Text(' mitchiko',
                    style: TextStyle(fontWeight: 
                    FontWeight.bold ),),
                    Text(' and'),
                    Text(' others ',
                    style: TextStyle(fontWeight: 
                    FontWeight.bold ),),

                  ],
                ),

         ),
         RichText(text: TextSpan(
          style: TextStyle(color: Colors.black),
          children: [
            TextSpan(
              text: 'kotathefriend',
              style: TextStyle(fontWeight: FontWeight.bold)
            ),
            TextSpan(
              text: 'i turn the dirty throuwing into riches til in filthy'
            )
          ]
         ))
      ],
    );
    
  }
}