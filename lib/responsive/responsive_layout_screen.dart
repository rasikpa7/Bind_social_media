import 'package:bind/utils/dimention.dart';
import 'package:flutter/material.dart';
class ResponsiveLayout extends StatelessWidget {
  final webScreenLayout;
  final mobileScreenLayout;
  const ResponsiveLayout({Key? key,required this.webScreenLayout,required this.mobileScreenLayout}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return LayoutBuilder(builder: (context, constraints) {

 

      if(constraints.maxWidth>webScreenSize){
        //web screen layout
             return webScreenLayout;
      }
      //mobile screen layout
           return mobileScreenLayout;
      
    },);
    
  }
}