import 'dart:typed_data';


import 'package:bind/controller/google_signIn_Provider.dart';
import 'package:bind/controller/userSignUp_provider.dart';
import 'package:bind/model/utils/utils.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:bind/model/utils/dimention.dart';

import 'package:bind/view/responsive/mobile_scree_layout.dart';
import 'package:bind/view/responsive/responsive_layout_screen.dart';
import 'package:bind/view/responsive/web_screen_layout.dart';
import 'package:bind/view/screens/loginScreen/logInScreen.dart';

import 'package:bind/view/widgets/text/fieldInput.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';




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

  Uint8List? image;

  bool isLoading= false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordController.dispose();
    _usernamecontroller.dispose();
    _bioController.dispose();
  }

    Future<String> signUpUser({
    required TextEditingController email,
    required TextEditingController password,
    required TextEditingController username,
    required TextEditingController bio,
    required Uint8List imageFile,
  }) async {
    // if(email.text.isEmpty||password.text.isEmpty||username.text.isEmpty||bio.text.isEmpty
    // ||imageFile.isEmpty){
    //   showSnackBarr('enter all fields', context);
      
    // }
    setState(() {
      isLoading=true;
      
    });
    
 
    String res = await AuthMethods().signUpUser(
       
        email: email.text.trim(),
        password: password.text.trim(),
        username: username.text.trim(),
        bio: bio.text.trim(),
        file: imageFile);
 
       setState(() {
          isLoading=false;
       });
    
        return res;

  
  
  }
  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      image = im;
    });
  }



  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);
    final googleUser=Provider.of<GoogleSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      
      body: Stack(
        children: [
           SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'lib/model/assets/signup_background.jpg',
                    // Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                    fit: BoxFit.fitHeight,
                  ),
                ),
          SafeArea(
              child: ListView(
            padding: MediaQuery.of(context).size.width > webScreenSize
                ? EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 3.5)
                : EdgeInsets.symmetric(horizontal: 5.w),
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
                        image != null
                            ? CircleAvatar(
                                radius: 50.r,
                                backgroundImage: MemoryImage(image!),
                              )
                            :  CircleAvatar(
                                radius: 50.r,
                                backgroundColor: Colors.grey[400],
                                backgroundImage: const NetworkImage(
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
                    //   }
                    // ),
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
                            onPressed: () async {
                              // final res = signUpProvider.
                          if(_emailcontroller.text.isEmpty||
                          _passwordController.text.isEmpty||
                          _usernamecontroller.text.isEmpty||
                          _bioController.text.isEmpty||image==null
                          ){
                            showSnackBarr('please enter all fields', context);
                            return;
                          }
                             final res=await signUpUser(
                                email: _emailcontroller,
                                password: _passwordController,
                                username: _usernamecontroller,
                                bio: _bioController,
                                imageFile: image!
                              );
                              if (res == 'success') {
                                showSnackBarr(res.toString(), context);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResponsiveLayout(
                                              mobileScreenLayout:
                                                  MobileScreenLayout(),
                                              webScreenLayout: WebScreenLayout(),
                                            )));
                              }  
                               
                               
                              showSnackBarr(res.toString(), context);
                              
                       
                              signUpProvider.clearImageFile();
                            },
                            child:  isLoading? 
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ):
                           const  Text(
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
                    isLoading?
                    const SizedBox():
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.green,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: IconButton(
                              onPressed: ()async {
                              final res=  await googleUser.googleSignUP(context);
                                if (res == 'success') {
                                showSnackBarr(res.toString(), context);
                                Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            const ResponsiveLayout(
                                              mobileScreenLayout:
                                                  MobileScreenLayout(),
                                              webScreenLayout: WebScreenLayout(),
                                            )));
                              }  
                               
                               
                              showSnackBarr(res.toString(), context);
                              },
                              icon: const FaIcon(
                                FontAwesomeIcons.google,
                                color: Colors.white,
                              )),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    RichText(
                        text: TextSpan(
                      children: [
                        const TextSpan(
                            text: 'Already have account ?',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: ' Log In',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => LogInScreen(),
                                ));
                              },
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold))
                      ],
                    ))
                  ],
                ),
              )
            ],
          )),
        ],
      ),
    );
  }
}
