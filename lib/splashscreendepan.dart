import 'dart:async';

import 'package:flutter/material.dart';
import 'package:splashscreen/splashscreen.dart';
import 'package:digitalent_absensi/login_page.dart';

class SplashScreenDepan extends StatefulWidget {
  static String tag = 'splash-depan';
  _SplashScreenDepanState createState() => _SplashScreenDepanState();
}

class _SplashScreenDepanState extends State<SplashScreenDepan> {
  
  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
    Navigator.of(context).pushReplacementNamed(LoginPage.tag);
  }

  void initState() { 
    super.initState();
    startTime();
  }
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new Center(
        child: new Image.asset('img/splash-screen.png', fit: BoxFit.cover,),
      ),
    );
  }
}