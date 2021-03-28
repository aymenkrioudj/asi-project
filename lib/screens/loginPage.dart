import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:asiproject/screens/homePage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';



class LoginPage extends StatefulWidget {
    static String id = "login";

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isLoggedIn = false;

  GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);

  _login() async{
    try{
      await _googleSignIn.signIn();
      
      setState(() {
        _isLoggedIn = true;
      });
    } catch (err){
      print(err);
    }
  }

  _logout(){
    _googleSignIn.signOut();
    setState(() {
      _isLoggedIn = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: colorWhite,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child:Image.asset('images/logo.png',
                width: MediaQuery.of(context).size.width / 2
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "ScolarESI for Management of absences in the Higher School of Computer Science",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 25,
                  fontFamily: "Titre1",
                  color: colorBlue1,
                ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:100,right:100,top:50),
              child: Divider(
                height: 20,
                thickness: 2,
                color: colorBlue1,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,top:10.0),
              child: Text("Log in",
                style: TextStyle(
                  fontSize: MediaQuery.of(context).size.width / 12,
                  fontFamily: "Titre1",
                  color: colorBlue1,
                ),
                ),
            ),
            Padding(
              padding: const EdgeInsets.only(left:10.0,right: 10.0),
                child: RichText(text: 
                  TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: "You should have an",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: colorBlue1,
                        fontFamily: "Titre1",
                      ),
                    ),
                    TextSpan(
                      text: " esi.dz ",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: colorBlue3,
                        fontWeight: FontWeight.bold,
                        fontFamily: "Titre1",
                      ),
                    ),
                    TextSpan(
                      text: "account to use this application",
                      style: TextStyle(
                        fontSize: MediaQuery.of(context).size.width / 20,
                        color: colorBlue1,
                        fontFamily: "Titre1",
                      ),
                    ),
                  ]
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child:  Container(
                  width: MediaQuery.of(context).size.width / 2,
                  child: Material(
                      color: colorBlue1,
                      borderRadius: BorderRadius.all(Radius.circular(30)),
                      child: InkWell(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        splashColor: colorBlue3, 
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                LineIcons.googlePlusG,
                                color: colorWhite, 
                                size: MediaQuery.of(context).size.width / 12,
                              ),
                              SizedBox(width:20),
                              Text('esi.dz',
                                  style: TextStyle(
                                    color: colorWhite,
                                    fontFamily: "Titre1",
                                    fontSize: MediaQuery.of(context).size.width / 20,
                                  ),
                                ),
                            ],
                          ),
                        ),
                        onTap: () async{
                          _login();
                          //TODO : hna li kayan prblem
                          if(_googleSignIn !=null)
                              Navigator.pushNamed(context, HomePage.id);
                        },
                      ),
                    ),
                ),
                ),
            ),
          ],
        ),
      ),
    );
  }
}