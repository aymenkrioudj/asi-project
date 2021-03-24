import 'package:asiproject/screens/loginPage.dart';
import 'package:flutter/material.dart';
import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:asiproject/constants.dart';

class SplashPage extends StatefulWidget {
  static String id = "splash";
  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AnimatedSplashScreen(
        duration: 2000,
        splash: Image.asset('images/logowhite.png'),
        nextScreen: LoginPage(),
        splashTransition: SplashTransition.fadeTransition,
        //pageTransitionType: PageTransitionType.scale,
        backgroundColor: colorBlue1,
      ),
    );
  }
}