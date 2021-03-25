import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:asiproject/screens/splashPage.dart';
import 'package:asiproject/screens/homePage.dart';
import 'package:asiproject/screens/scanPage.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Absence Management',
      theme: ThemeData(
                primaryColor: colorBlue1,
        scaffoldBackgroundColor: colorWhite,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {
        HomePage.id: (context) => HomePage(),
        ScanPage.id: (context) => ScanPage(),

      },
    );
  }
}

