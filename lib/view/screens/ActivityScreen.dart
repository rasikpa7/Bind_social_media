import 'package:bind/view/screens/screenwidgets/activity_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class ActivityScreen extends StatelessWidget {
   ActivityScreen({Key? key}) : super(key: key);
  final List people=[
'salsal','jafer',
'kiran','karthik',
'razik',
'salsal','jafer',
'kiran','karthik',
'razik',
'salsal','jafer',
'kiran','karthik',
'razik','salsal','jafer',
'kiran','karthik',
'razik','salsal','jafer',
'kiran','karthik',
'razik'
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: ListView.builder(itemCount: people.length,
        itemBuilder: ((context, index) =>
      Activitytile(name: people[index],) )),
    );
    
  }
}