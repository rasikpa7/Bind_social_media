import 'package:bind/responsive/mobile_scree_layout.dart';
import 'package:bind/responsive/responsive_layout_screen.dart';
import 'package:bind/responsive/web_screen_layout.dart';
import 'package:bind/utils/dimention.dart';
import 'package:bind/view/loginScreen/logInScreen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
            primarySwatch: Colors.blue,
            scaffoldBackgroundColor: const Color(0XFFEFF3F6)),
        home: const ResponsiveLayout(
          mobileScreenLayout: MobileScreenLayout(),
          webScreenLayout: WebScreenLayout(),
        ));
  }
}
