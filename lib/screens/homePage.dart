import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:bubble_timeline/bubble_timeline.dart';
import 'package:line_icons/line_icons.dart';
import 'package:asiproject/screens/scanPage.dart';
import 'package:timelines/timelines.dart';




class HomePage extends StatefulWidget {
  static String id = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  
  List sessions = <Session>[
    Session("ASI Cours", "Fouad Dahak", "(AP2)", DateTime.now(), DateTime.now()),
    Session("BDA Cours", "Karima Amrouche", "(A3)", DateTime.now(), DateTime.now()),
    Session("ASI TD", "Sabrina Abdelaoui", "(CP7)", DateTime.now(), DateTime.now()),
    Session("PGI TD", "Selma Khouri", "(CP9)", DateTime.now(), DateTime.now()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.white),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
        ),
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'ScolarESI',
          style: TextStyle(
            fontSize: MediaQuery.of(context).size.height / 40,
            fontWeight: FontWeight.normal,
            color: colorBlue1,
            fontFamily: "Titre1",
          ),
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                for (var i = 0; i < sessions.length; i++) 
                  Timeline(
                    i,
                    sessions[i].module,
                    sessions[i].prof,
                    sessions[i].salle, 
                    sessions[i].dateD,
                    sessions[i].dateF,
                  ),

              ],
            ),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, ScanPage.id);
              },
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Text(
                      "Tap here to scan :",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                      fontSize: MediaQuery.of(context).size.width / 15,
                      fontFamily: "Titre1",
                      color: colorBlue2,
                    ),
                    ),
                  ),
                  Center(
                    child:Image.asset('images/qrcode.png',
                    width: MediaQuery.of(context).size.width / 2
                    ),
                  ),
                ],
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}


class Session {
  Session(this.module,this.prof,this.salle,this.dateD,this.dateF);
  
  String module;
  String prof;
  String salle;
  DateTime dateD;
  DateTime dateF;
}

class Timeline extends StatelessWidget {
  final int index;
  final String module;
  final String prof;
  final String salle;
  final DateTime dateD;
  final DateTime dateF;

  Timeline(this.index,this.module,this.prof,this.salle,this.dateD,this.dateF);

  @override
  Widget build(BuildContext context) {
    return TimelineTile(
              oppositeContents: 
                index % 2 == 0 
                ? ContentTime(dateD)
                : ContentCard(module,prof,salle,dateD,dateF),
              contents: 
                index % 2 == 1
                ? ContentTime(dateD)
                : ContentCard(module,prof,salle,dateD,dateF),
              node: TimelineNode(
                indicator: DotIndicator(
                  child: Icon(
                    LineIcons.clockAlt,
                    color: colorWhite, 
                    size: MediaQuery.of(context).size.width / 14,
                  ),
                ),
                startConnector: SolidLineConnector(
                  color: colorBlue3,
                  thickness: 3,
                ),
                endConnector: SolidLineConnector(
                  color: colorBlue3,
                  thickness: 3,
                ),
              ),
            );
  }
}

class ContentTime extends StatelessWidget {
  final DateTime date;
  ContentTime(this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  date.hour.toString()+":"+date.minute.toString(),
                  style: TextStyle(
                    color: colorBlue1,
                    fontFamily: "Titre1",
                    fontSize: MediaQuery.of(context).size.height / 30,
                  ),
                ),
      );
  }
}

class ContentCard extends StatelessWidget {
  final String module;
  final String prof;
  final String salle;
  final DateTime dateD;
  final DateTime dateF;

  ContentCard(this.module,this.prof,this.salle,this.dateD,this.dateF);

  @override
  Widget build(BuildContext context) {
    return Card(
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        module,
                        style:TextStyle(
                        color: colorBlue1,
                        fontFamily: "Titre1",
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 40,
                        ),
                      ),
                      Text(
                        prof,
                        style:TextStyle(
                        color: colorBlue1,
                        fontFamily: "Titre1",
                        //fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      Text(
                        salle,
                        style:TextStyle(
                        color: colorBlue1,
                        fontFamily: "Titre1",
                        //fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 60,
                        ),
                      ),
                    ],
                  ),
                ),
              );
  }
}