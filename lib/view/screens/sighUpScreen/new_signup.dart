
import 'package:bind/model/utils/utils.dart';
import 'package:bind/view/screens/loginScreen/logInScreen.dart';
import 'package:bind/view/screens/loginScreen/new_loginPage.dart';
import 'package:bind/view/widgets/text/fieldInput.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../controller/google_signIn_Provider.dart';
import '../../../controller/userSignUp_provider.dart';
import '../../../controller/user_provider.dart';
import '../../../resources/auth_methods.dart';
import '../../responsive/mobile_scree_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../sighUpScreen/signUpScreen.dart';





class NewSignUp extends StatefulWidget {
  @override
  State<NewSignUp> createState() => _NewSignUpState();
}

class _NewSignUpState extends State<NewSignUp> {
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
    bool isLoading = Provider.of<UserProvider>(context).isLoading;
    final signUpProvider = Provider.of<SignUpProvider>(context, listen: false);

    final googleUser=Provider.of<GoogleSignInProvider>(context);
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: size.height,
            child: Stack(
              children: [
                SizedBox(
                  height: size.height,
                  child: Image.asset(
                    'lib/model/assets/signup_background.jpg',
                    // Image Url: https://unsplash.com/photos/bOBM8CB4ZC4
                    fit: BoxFit.fitHeight,
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Expanded(
                        child: SizedBox(),
                      ),
                      Expanded(
                        flex: 7,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(30),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaY: 25, sigmaX: 25),
                            child: SizedBox(
                              width: size.width * .9,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                      top: size.width * .15,
                                      
                                    ),
                                    child: Text(
                                      'SIGN UP',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
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
                    SizedBox(height: 10,),
                                  component(Icons.email_rounded, 'Email', false, true, _emailcontroller),
                                  component(Icons.password_outlined, 'password', true, false, _passwordController),
                                  component(Icons.man ,'Username', false, true,_usernamecontroller ),
                                  component(Icons.abc, 'Bio', false, true, _bioController),
                              
                             
                    
           
                                 
                                  InkWell(
                                    onTap: ()async {
                            final res= await     googleUser.googleSignUP(context);

                            if(res=='success'){
                                    Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ResponsiveLayout(
                                          mobileScreenLayout:
                                              MobileScreenLayout(),
                                          webScreenLayout: WebScreenLayout(),
                                        )));
                            }
                              
                              },
                                    child: Container(height: 30.h,width: 170.w,decoration: BoxDecoration(borderRadius: BorderRadius.circular(20.r),color: Colors.black.withOpacity(0.1),),
                                    child: Row(children: [
                                    Container(height: 30.h,width: 30.w,color: Colors.transparent,
                                    child:Image.asset('lib/model/assets/google_logo.png',fit: BoxFit.fill,)
                                                                  
                                    ),
                                    Text('Login with Google',style: TextStyle(color: Colors.white),)
                                    ]),
                                    
                                    
                                    ),
                                  ),
                                 
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: ()async {
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
                                    child: Container(
                                      margin: EdgeInsets.only(
                                        bottom: size.width * .05,
                                      ),
                                      height: size.width / 8,
                                      width: size.width / 1.25,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: isLoading?  const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ): Text(
                                        'Sign-Up',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
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
                                  builder: (context) => NewHomePage(),
                                ));
                              },
                            style: const TextStyle(
                                color: Colors.blueAccent,
                                fontWeight: FontWeight.bold))
                      ],
                    ))
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: SizedBox(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(
      IconData icon, String hintText, bool isPassword, bool isEmail,TextEditingController? textcontroller,) {
    Size size = MediaQuery.of(context).size;
    return Container(
      height: size.width / 8,
      width: size.width / 1.25,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: size.width / 30),
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextField(
        controller:textcontroller ,
        style: TextStyle(
          color: Colors.white.withOpacity(.9),
        ),
        obscureText: isPassword,
        keyboardType: isEmail ? TextInputType.emailAddress : TextInputType.visiblePassword,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.8),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
   void LogInUser(BuildContext context) async {
    // isLoading=true;
    Provider.of<UserProvider>(context, listen: false).isLoadingValue(true);

    String res = await AuthMethods().loginUser(
        email: _emailcontroller.text, password: _passwordController.text);

    if (res == 'success') {
      // isLoading=false;
      Provider.of<UserProvider>(context, listen: false).isLoadingValue(false);

      showSnackBarr(res, context);

      Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (context) => const ResponsiveLayout(
                mobileScreenLayout: MobileScreenLayout(),
                webScreenLayout: WebScreenLayout(),
              )));
    } else {
      // isLoading=false;
      Provider.of<UserProvider>(context, listen: false).isLoadingValue(false);

      showSnackBarr(res, context);
    }
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
    BuildContext context,
    Widget child,
    AxisDirection axisDirection,
  ) {
    return child;
  }
}
