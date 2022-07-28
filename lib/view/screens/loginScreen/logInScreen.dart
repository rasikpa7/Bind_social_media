import 'package:bind/provider/user_provider.dart';
import 'package:bind/resources/auth_methods.dart';
import 'package:bind/responsive/mobile_scree_layout.dart';
import 'package:bind/responsive/responsive_layout_screen.dart';
import 'package:bind/responsive/web_screen_layout.dart';
import 'package:bind/utils/dimention.dart';
import 'package:bind/utils/utils.dart';
import 'package:bind/view/sighUpScreen/signUpScreen.dart';
import 'package:bind/view/widgets/text/fieldInput.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatelessWidget {
  LogInScreen({Key? key}) : super(key: key);

  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  showLoaderDialog(BuildContext context) {
    AlertDialog alert = AlertDialog(
      content:  Row(
        children: [
          CircularProgressIndicator(),
          Container(
              margin: EdgeInsets.only(left: 7.w), child: Text("Loading...")),
        ],
      ),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isLoading = Provider.of<UserProvider>(context).isLoading;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: MediaQuery.of(context).size.width > webScreenSize
              ? EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width / 3.5)
              : EdgeInsets.symmetric(horizontal: 5.w),
          children: [
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25.r),
                    bottomRight: Radius.circular(25.r)),
                color: Colors.grey.withOpacity(0.3),
              ),
              height: 250.h,
              child: Lottie.network(
                  'https://assets5.lottiefiles.com/packages/lf20_dn6rwtwl.json',
                  fit: BoxFit.contain),
            ),
            Container(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: EdgeInsets.all(18.0.r),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10.h,
                    ),
                    Text(
                      'Login',
                      style: GoogleFonts.lato(
                          letterSpacing: 2.w,
                          fontWeight: FontWeight.w900,
                          fontSize: 30.sp,
                          color: const Color.fromARGB(255, 11, 90, 155)),
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
                    Container(
                      width: 320.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30.r)),
                      height: 45.h,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15.r),
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              primary: Colors.blue,
                            ),
                            onPressed: () {
                              LogInUser(context);
                              isLoading
                                  ? showLoaderDialog(context)
                                  : Container();
                            },
                            child: const Text(
                              'LogIn',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 15.h,
                    ),
                    const Text('Or sign in with'),
                    SizedBox(
                      height: 10.h,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 100.w,
                          decoration: BoxDecoration(
                              color: Colors.teal,
                              borderRadius: BorderRadius.circular(15.r)),
                          child: IconButton(
                              onPressed: () {},
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
                            text: 'Dont have account ?',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'sign Up',
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => SignUpScreen(),
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
            )
          ],
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
