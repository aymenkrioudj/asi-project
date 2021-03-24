import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:asiproject/screens/splashPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
                primaryColor: colorBlue1,
        scaffoldBackgroundColor: colorWhite,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SplashPage(),
      routes: {

      },
    );
  }
}

