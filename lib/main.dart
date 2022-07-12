import 'package:bind/responsive/mobile_scree_layout.dart';
import 'package:bind/responsive/responsive_layout_screen.dart';
import 'package:bind/responsive/web_screen_layout.dart';
import 'package:bind/utils/dimention.dart';
import 'package:bind/view/loginScreen/logInScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
            apiKey: 'AIzaSyDVVcFYzM_3oWISRbC5llM99rIylPqnCyE',
            appId: '1:78811063023:web:27eb8a3be5a845c336b11a',
            messagingSenderId: '78811063023',
            projectId: 'bind-social-media',
            storageBucket:'bind-social-media.appspot.com'
            ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
         designSize: const Size(392.7, 781.1),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => 
      MaterialApp(
          debugShowCheckedModeBanner: false,
         
          theme: ThemeData(
              primarySwatch: Colors.blue,
              scaffoldBackgroundColor: const Color(0XFFEFF3F6)),
          home: const ResponsiveLayout(
            mobileScreenLayout: MobileScreenLayout(),
            webScreenLayout: WebScreenLayout(),
          )),
    );
  }
}
