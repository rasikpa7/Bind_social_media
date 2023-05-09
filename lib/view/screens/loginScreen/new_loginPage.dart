
import 'package:bind/model/utils/utils.dart';
import 'package:bind/view/widgets/text/fieldInput.dart';
import 'package:flutter/material.dart';
import 'dart:ui';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../../../controller/google_signIn_Provider.dart';
import '../../../controller/user_provider.dart';
import '../../../resources/auth_methods.dart';
import '../../responsive/mobile_scree_layout.dart';
import '../../responsive/responsive_layout_screen.dart';
import '../../responsive/web_screen_layout.dart';
import '../sighUpScreen/new_signup.dart';
import '../sighUpScreen/signUpScreen.dart';



void main() {
  runApp(
    MaterialApp(
      title: 'Translucent Login UI',
      home: NewHomePage(),
    ),
  );
}


class NewHomePage extends StatefulWidget {
  @override
  State<NewHomePage> createState() => _NewHomePageState();
}

class _NewHomePageState extends State<NewHomePage> {

   final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
    

  Widget build(BuildContext context) {

    bool isLoading = Provider.of<UserProvider>(context).isLoading;

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
                    'lib/model/assets/background_image.jpg',
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
                                      bottom: size.width * .1,
                                    ),
                                    child: Text(
                                      'SIGN IN',
                                      style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.w600,
                                        color: Colors.white.withOpacity(.8),
                                      ),
                                    ),
                                  ),
                                  component(Icons.email_rounded, 'Email', false, true, _emailcontroller),
                                  component(Icons.password_outlined, 'password', true, false, _passwordController),
                             
                    
           
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      RichText(
                                        text: TextSpan(
                                          text: 'Forgotten password!',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                          recognizer: TapGestureRecognizer()
                                            ..onTap = () {
                                              HapticFeedback.lightImpact();
                                              Fluttertoast.showToast(
                                                msg:
                                                    'Forgotten password! button pressed',
                                              );
                                            },
                                        ),
                                      ),
                                      RichText(
                                        text: TextSpan(
                                          text: 'Create a new Account',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                         recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => NewSignUp(),
                                ));
                              },
                                        ),
                                      ),
                                    ],
                                  ),
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
                                  SizedBox(height: size.width * .02),
                                  InkWell(
                                    splashColor: Colors.transparent,
                                    highlightColor: Colors.transparent,
                                    onTap: () {
                                      HapticFeedback.lightImpact();
                                       LogInUser(context);
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
                                      child: Text(
                                        'Sign-In',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  ),
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
