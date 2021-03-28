import 'dart:async';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';


import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:timelines/timelines.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:cool_alert/cool_alert.dart';






class HomePage extends StatefulWidget {
  static String id = "home";
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  List sessions = <Session>[
    Session("ASI Cours", "Fouad Dahak", "(AP2)", TimeOfDay(hour: 8, minute: 30), TimeOfDay(hour: 10, minute: 30)),
    Session("BDA Cours", "Karima Amrouche", "(A3)", TimeOfDay(hour: 10, minute: 40), TimeOfDay(hour: 12, minute: 10)),
    Session("ASI TD", "Sabrina Abdelaoui", "(CP7)", TimeOfDay(hour: 13, minute: 30), TimeOfDay(hour: 15, minute: 00)),
    Session("PGI TD", "Selma Khouri", "(CP9)", TimeOfDay(hour: 15, minute: 10), TimeOfDay(hour: 16, minute: 40)),
  ];

//TODO : les methodes de scan QR code 
  
  String _scanBarcode = 'Unknown QR code"';

  void initState() {
    super.initState();
  }

  Future<void> scanQR() async {
    String barcodeScanRes;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      barcodeScanRes = await FlutterBarcodeScanner.scanBarcode(
          "#ff6666", "Cancel", true, ScanMode.QR);
      print(barcodeScanRes);
    } on PlatformException {
      barcodeScanRes = 'Failed to get QR code.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _scanBarcode = barcodeScanRes;
      String datenow = DateFormat('yyyy-MM-dd').format(DateTime.now());
      String hournow = DateFormat('kk:mm:ss').format(DateTime.now());
      bool isSession = false;
      if (_scanBarcode=="ASI Cours" && compareDate(sessions[0].dateD, sessions[0].dateF)) { isSession= true;}
      if (_scanBarcode=="BDA Cours" && compareDate(sessions[1].dateD, sessions[1].dateF)) { isSession= true;}
      if (_scanBarcode=="ASI TD" && compareDate(sessions[2].dateD, sessions[2].dateF)) { isSession= true;}
      if (_scanBarcode=="PGI TD" && compareDate(sessions[3].dateD, sessions[3].dateF)) { isSession= true;}
      if (_scanBarcode == "-1") {
        //cancel : do nothing
      } else {
        CoolAlert.show(
                        context: context,
                        type: isSession
                          ? CoolAlertType.success
                          : CoolAlertType.error,
                        title: isSession
                          ? "Confirmed presence to :"
                          : "Qr code not validated",
                        text: isSession
                          ?_scanBarcode + "\n" + hournow + "\n" + datenow
                          : "This session does not currently exist or maybe this QR code does not correspond to this session",
                        backgroundColor: colorBlue1,
                        confirmBtnColor: colorBlue1,
                        //confirmBtnTap: (){}
                      );
      }
    });
  }

  Future<bool> _onBackPressed() {
      return showDialog(
        context: context,
        builder: (context) => new AlertDialog(
          title: new Text('Are you sure?', style: TextStyle(color: colorBlue1, fontFamily: "Titre1",fontWeight: FontWeight.bold)),
          content: new Text('Do you want to exit an App', style: TextStyle(color: colorBlue1, fontFamily: "Titre1")),
          actions: <Widget>[
            new GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Text("NO", style: TextStyle(color: colorBlue1, fontFamily: "Titre1")),
            ),
            SizedBox(height: 16),
            new GestureDetector(
              onTap: () => SystemNavigator.pop(),
              child: Text("YES", style: TextStyle(color: colorBlue1, fontFamily: "Titre1")),
            ),
          ],
        ),
      ) ??
      false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onBackPressed,
          child: Scaffold(
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
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
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
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    scanQR();
                    //print(TimeOfDay.now());
                    //Navigator.pushNamed(context, ScanPage.id);
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
              ),
            ],
          ),
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
  TimeOfDay dateD;
  TimeOfDay dateF;
}

class Timeline extends StatelessWidget {
  final int index;
  final String module;
  final String prof;
  final String salle;
  final TimeOfDay dateD;
  final TimeOfDay dateF;

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
                  color: colorBlue2,
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
  final TimeOfDay date;
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

class ContentCard extends StatefulWidget {
  final String module;
  final String prof;
  final String salle;
  final TimeOfDay dateD;
  final TimeOfDay dateF;

  ContentCard(this.module,this.prof,this.salle,this.dateD,this.dateF);

  @override
  _ContentCardState createState() => _ContentCardState();
}


class _ContentCardState extends State<ContentCard> {
  

  @override
  Widget build(BuildContext context) {
    return Card(
                color: compareDate(widget.dateD, widget.dateF)
                  ? colorBlue3
                  : Colors.white,
                child: Container(
                  padding: EdgeInsets.all(5.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.module,
                        style:TextStyle(
                        color: compareDate(widget.dateD, widget.dateF)
                          ? Colors.white
                          : colorBlue1,
                        fontFamily: "Titre1",
                        fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 40,
                        ),
                      ),
                      Text(
                        widget.prof,
                        style:TextStyle(
                        color: compareDate(widget.dateD, widget.dateF)
                          ? Colors.white
                          : colorBlue1,
                        fontFamily: "Titre1",
                        //fontWeight: FontWeight.bold,
                        fontSize: MediaQuery.of(context).size.height / 50,
                        ),
                      ),
                      Text(
                        widget.salle,
                        style:TextStyle(
                        color: compareDate(widget.dateD, widget.dateF)
                          ? Colors.white
                          : colorBlue1,
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


compareDate(TimeOfDay dd,TimeOfDay df){
    int dd_to_min = dd.hour*60 + dd.minute;
    int df_to_min = df.hour*60 + df.minute;
    int now_to_min = (TimeOfDay.now().hour)*60 + TimeOfDay.now().minute;

    if (now_to_min>=dd_to_min && now_to_min <df_to_min) {
      return true;
    }
    return false;
  }