import 'package:bind/controller/user_provider.dart';

import 'package:bind/view/screens/splashScreen/splashScreen.dart';

import 'package:get/get.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';

import 'controller/google_signIn_Provider.dart';
import 'controller/userSignUp_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDVVcFYzM_3oWISRbC5llM99rIylPqnCyE',
            appId: '1:78811063023:web:27eb8a3be5a845c336b11a',
            messagingSenderId: '78811063023',
            projectId: 'bind-social-media',
            storageBucket: 'bind-social-media.appspot.com'));
  } else {
    await Firebase.initializeApp();
  }

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(392.7, 781.1),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => UserProvider()),
          ChangeNotifierProvider(create: (_) => SignUpProvider()),
          ChangeNotifierProvider(create: (_) => GoogleSignInProvider())
        ],
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              appBarTheme: AppBarTheme(color: Color(0xff003585)),
              primaryColor: Color(0xffFEBA02),
              scaffoldBackgroundColor: const Color(0XFFEFF3F6)),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
