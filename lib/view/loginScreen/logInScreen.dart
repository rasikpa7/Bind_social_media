import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class LogInScree extends StatelessWidget {
  const LogInScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        SafeArea(
          child: ListView(
          children: [
              Container(height: 250,color: Colors.grey.withOpacity(0.4),),
              Container(alignment: Alignment.topLeft,

              

                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Login',style: TextStyle(fontWeight: FontWeight.w900,fontSize: 30,color: Color.fromARGB(255, 11, 90, 155)),),
                    SizedBox(height: 20,),
                 TextFormField(
                  decoration: InputDecoration(
                    label: Text('Email'),
                    prefixIcon: Icon(Icons.email),
                    hintText: 'example.gmail.com',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                 ),
                    SizedBox(height: 15,),
                     TextFormField(obscureText: true,
                  decoration: InputDecoration(
                    label: Text('Password'),
                    prefixIcon: Icon(Icons.password),
                    
                    hintText: 'abc1239ab',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                 ),
                    ],
                  ),
                ),
              )
          ],),
        ),
      );
 
  }
}