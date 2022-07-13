import 'package:bind/resources/auth_methods.dart';
import 'package:bind/utils/utils.dart';
import 'package:bind/view/widgets/text/fieldInput.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:google_fonts/google_fonts.dart';

class LogInScreen extends StatefulWidget {
  LogInScreen({Key? key}) : super(key: key);

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailcontroller = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading=false;
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _emailcontroller.dispose();
    _passwordController.dispose();
  }

void LogInUser()async{
  
  setState(() {
  _isLoading=true;  
  });
  String res= await AuthMethods().loginUser(email: _emailcontroller.text, password: _passwordController.text);

if(res=='success'){
  setState(() {  
  
  _isLoading=false;
});
 showSnackBarr(res, context);

}else{
  //snackbar
  setState(() {
  
  _isLoading=false;
});
  showSnackBarr(res, context);
}



}
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
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
                          color: Color.fromARGB(255, 11, 90, 155)),
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
                              primary: Colors.teal,
                            ),
                            onPressed: () {
                              LogInUser();
                            },
                            child: _isLoading?
                            const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ):
                             const Text(
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
                        text:  TextSpan(
                      children: [
                        TextSpan(
                            text: 'Dont have account ?',
                            style: TextStyle(color: Colors.black)),
                        TextSpan(
                            text: 'sign Up',
                            recognizer: TapGestureRecognizer()
                            ..onTap = (){

                            },
                            style: TextStyle(
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
}
