import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return MaterialApp(
      title: 'Kali Calculator',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      //home: const MyHomePage(title: 'Kali Calculator'),
      home: AnimatedSplashScreen(
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: 150,
        duration: 1000,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.deepOrangeAccent,
        splash: Center(
          child: Image.asset('images/AppIcon.png')
        ),
        nextScreen: const MyHomePage(title: 'Kali Calculator'),
      ),
    );
  }
}