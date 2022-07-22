import 'dart:typed_data';

import 'package:bind/resources/auth_methods.dart';
import 'package:bind/responsive/mobile_scree_layout.dart';
import 'package:bind/responsive/responsive_layout_screen.dart';
import 'package:bind/responsive/web_screen_layout.dart';
import 'package:bind/utils/utils.dart';
import 'package:bind/view/screens/loginScreen/logInScreen.dart';

import 'package:bind/view/widgets/text/fieldInput.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final TextEditingController _usernamecontroller = TextEditingController();

  final TextEditingController _bioController = TextEditingController();

  Uint8List? _image;

  bool _isLoading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordController.dispose();
    _usernamecontroller.dispose();
    _bioController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }
    showLoaderDialog(BuildContext context){
    AlertDialog alert=AlertDialog(
      content: new Row(
        children: [
          CircularProgressIndicator(),
          Container(margin: EdgeInsets.only(left: 7),child:Text("Loading..." )),
        ],),
    );
    }

  void signUpUser()async{

    setState(() {
      _isLoading=true;
    });
       String res= await AuthMethods().signUpUser(isGoogle: false,
                              email: _emailcontroller.text.trim(),
                              password: _passwordController.text.trim(),
                              username: _usernamecontroller.text.trim(),
                              bio: _bioController.text,
                              file: _image!);


if(res!='success'){
  showSnackBarr(res, context);
  Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context)=>const  ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
   ) ));

}
 showSnackBarr(res, context);
 setState(() {
      _isLoading=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: ListView(
        children: [
          Padding(
            padding: EdgeInsets.all(18.0.r),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  height: 25.h,
                ),
                Text(
                  'SIGN UP',
                  style: GoogleFonts.lato(
                      letterSpacing: 2.w,
                      fontWeight: FontWeight.w900,
                      fontSize: 30.sp,
                      color: Color.fromARGB(255, 11, 90, 155)),
                ),
                SizedBox(
                  height: 25.h,
                ),
                Stack(
                  children: [
                    _image != null
                        ? CircleAvatar(
                            radius: 50,
                            backgroundImage: MemoryImage(_image!),
                          )
                        : CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://t4.ftcdn.net/jpg/00/64/67/63/360_F_64676383_LdbmhiNM6Ypzb3FM4PPuFP9rHe7ri8Ju.jpg'),
                          ),
                    Positioned(
                        bottom: -10,
                        left: 55,
                        child: IconButton(
                            onPressed: () async {
                              selectImage();
                            },
                            icon: const Icon(Icons.add_a_photo)))
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                TextFieldInput(
                    hintText: 'Example@gmail.com',
                    isPass: false,
                    label: 'Email',
                    prefixIcon: Icons.email,
                    textEditingController: _emailcontroller,
                    textInputType: TextInputType.emailAddress),
                SizedBox(
                  height: 15.h,
                ),
                TextFieldInput(
                  hintText: 'password',
                  textEditingController: _passwordController,
                  textInputType: TextInputType.visiblePassword,
                  label: 'Password',
                  prefixIcon: Icons.password,
                  isPass: true,
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextFieldInput(
                  hintText: 'Username',
                  textEditingController: _usernamecontroller,
                  textInputType: TextInputType.visiblePassword,
                  label: 'Username',
                  prefixIcon: Icons.man,
                ),
                SizedBox(
                  height: 15.h,
                ),
                TextFieldInput(
                  hintText: 'Bio',
                  textEditingController: _bioController,
                  textInputType: TextInputType.visiblePassword,
                  label: 'Bio',
                  prefixIcon: Icons.abc,
                ),
                SizedBox(
                  height: 15.h,
                ),
                Container(
                  width: 320.w,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(30.r)),
                  height: 45.h,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15.r),
                    child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.teal,
                        ),
                        onPressed: () async{
                              signUpUser();
                                 _isLoading?showLoaderDialog(context):Container();
                          
                     
                        },
                        child:
                         const Text(
                          'Sign Up',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        )),
                  ),
                ),
                SizedBox(
                  height: 15.h,
                ),
                const Text('Or Sign Up with'),
                SizedBox(
                  height: 10.h,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.green,
                          borderRadius: BorderRadius.circular(15.r)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.google,
                            color: Colors.white,
                          )),
                    ),
                    SizedBox(
                      width: 5.w,
                    ),
                    Container(
                      width: 100.w,
                      decoration: BoxDecoration(
                          color: Colors.lightBlue,
                          borderRadius: BorderRadius.circular(15)),
                      child: IconButton(
                          onPressed: () {},
                          icon: const FaIcon(
                            FontAwesomeIcons.facebook,
                            color: Colors.white,
                          )),
                    )
                  ],
                ),
                SizedBox(
                  height: 30.h,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                        text: 'Already have account ?',
                        style: TextStyle(color: Colors.black)),
                    TextSpan(
                        text: ' Log In',
                        recognizer: TapGestureRecognizer()..onTap = () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) =>LogInScreen() ,));
                        },
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontWeight: FontWeight.bold))
                  ],
                ))
              ],
            ),
          )
        ],
      )),
    );
  }
  
 
}
