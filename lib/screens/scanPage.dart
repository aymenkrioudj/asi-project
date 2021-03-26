import 'package:flutter/material.dart';
import 'package:asiproject/constants.dart';
import 'package:line_icons/line_icons.dart';
import 'package:qr_flutter/qr_flutter.dart';


class ScanPage extends StatefulWidget {
  static String id = "scan";

  @override
  _ScanPageState createState() => _ScanPageState();
}

class _ScanPageState extends State<ScanPage> {
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
        child: Container(),
      ),

    );
  }
}