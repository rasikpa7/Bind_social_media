import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ExploreGrid extends StatelessWidget {
  const ExploreGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    
    return GridView.builder(
  
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 3
    ), itemBuilder: (context,index){
return Padding(
  padding: const EdgeInsets.all(4.0),
  child:   Container(
    decoration: BoxDecoration(
                    image: DecorationImage(
      image: NetworkImage("https://cdn.pixabay.com/photo/2014/02/27/16/10/tree-276014_960_720.jpg"),
      fit: BoxFit.cover),
    ),
  
    
  
  ),
);

    });
  }
}