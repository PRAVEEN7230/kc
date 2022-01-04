import 'package:flutter/material.dart';
import 'package:kc/splash_screen.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'home_page.dart';
import 'package:page_transition/page_transition.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Kali Calculator',
      debugShowCheckedModeBanner: false,

      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
      ),
      home: AnimatedSplashScreen(
        splashTransition: SplashTransition.scaleTransition,
        splashIconSize: 180,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: Colors.deepOrangeAccent,
        splash: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: 120,
              width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.white,
                  image: const DecorationImage(fit: BoxFit.cover,
                    image:  AssetImage('images/AppIcon.png'),)
              ),
            ),
            const SizedBox(height: 15,),
            const Text(
              'Kali Calculator',
              style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.white
              ),
            ),
          ],
        ),
        nextScreen: const MyHomePage(title: 'Kali Calculator'),
      ),
    );
  }
}