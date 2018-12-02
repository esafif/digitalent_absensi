import 'package:flutter/material.dart';

class logAbsensi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log Absensi"),
        backgroundColor: Colors.lightBlue[600],
      ),
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.lightBlue[700], Colors.white30])),
      ),
    );
  }
}