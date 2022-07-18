import 'package:bind/provider/user_provider.dart';
import 'package:bind/utils/dimention.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class ResponsiveLayout extends StatefulWidget {
  final webScreenLayout;
  final mobileScreenLayout;
  const ResponsiveLayout({Key? key,required this.webScreenLayout,required this.mobileScreenLayout}) : super(key: key);

  @override
  State<ResponsiveLayout> createState() => _ResponsiveLayoutState();
}

class _ResponsiveLayoutState extends State<ResponsiveLayout> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   addData();
  }
  
  void addData()async{
    await Provider.of<UserProvider>(context,listen: false).refreshUser();

//  await _userProvider.refreshUser();
  }

  @override
  Widget build(BuildContext context) {


    return LayoutBuilder(builder: (context, constraints) {

 

      if(constraints.maxWidth>webScreenSize){
        //web screen layout
             return widget.webScreenLayout;
      }
      //mobile screen layout
           return widget.mobileScreenLayout;
      
    },);
    
  }
}