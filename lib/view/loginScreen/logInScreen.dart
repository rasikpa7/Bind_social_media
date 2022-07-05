import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
class LogInScree extends StatelessWidget {
  const LogInScree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:
        SafeArea(
          child: ListView(
          children: [
              Container(decoration: BoxDecoration(borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(25),
                bottomRight: Radius.circular(25)
              ),
              color: Colors.grey.withOpacity(0.3),),
                height: 250,
              child: Lottie.network('https://assets5.lottiefiles.com/packages/lf20_dn6rwtwl.json',fit: BoxFit.contain),),
              Container(
                alignment: Alignment.topLeft,



                child: Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                    SizedBox(height: 10,),
                      Text('Login',style:  GoogleFonts.lato(letterSpacing: 2,
                        fontWeight: FontWeight.w900,fontSize: 30,color: Color.fromARGB(255, 11, 90, 155)),),
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
                    
                    hintText: 'password',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(20))
                  ),
                 ),
                  SizedBox(height: 15,),
                 Container(width: 320,
                 decoration: BoxDecoration(
                
                  borderRadius: BorderRadius.circular(30)
                 ),
                 height: 45,
                   child: ClipRRect(borderRadius: BorderRadius.circular(15),
                     child: ElevatedButton(style:ElevatedButton.styleFrom(
                      primary: Colors.teal,
                     ) ,
                      onPressed: (){
                   
                     }, child: Text('LogIn',style: TextStyle(fontWeight: FontWeight.bold),)),
                   ),
                 ),
   SizedBox(height: 15,),
                 Text('Or sign in with'),
                 SizedBox(height: 10,),
                 Row(mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                Container(
                  width: 100,
                decoration: BoxDecoration(color: Colors.green,
                  borderRadius: BorderRadius.circular(15)),
                  child: IconButton(onPressed: (){

                  }, icon: FaIcon(FontAwesomeIcons.google,color: Colors.white,)),
                ),
                SizedBox(width: 5,),
                     Container(
                      width: 100,
                decoration: BoxDecoration(color: Colors.lightBlue,
                  borderRadius: BorderRadius.circular(15)),
                  child: IconButton(onPressed: (){

                  }, icon: FaIcon(FontAwesomeIcons.facebook,color: Colors.white,)),
                )
                   ],
                 )

              
                    ],
                  ),
                ),
              )
          ],),
        ),
      );
 
  }
}