import 'package:asiproject/blocs/auth_blocs.dart';
import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:asiproject/screens/splashPage.dart';
import 'package:asiproject/screens/homePage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      create: (context) => AuthBloc(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Absence Management',
        theme: ThemeData(
          primaryColor: colorBlue1,
          scaffoldBackgroundColor: colorWhite,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: SplashPage(),
        routes: {
          HomePage.id: (context) => HomePage(),
        },
      ),
    );
  }
}
