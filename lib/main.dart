import 'package:flutter/material.dart';
import 'login_page.dart';
import 'home_page.dart';
import 'employee.dart';
import 'absensi_today.dart';
import 'splashscreendepan.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {

  final routes = <String, WidgetBuilder>{
    LoginPage.tag: (context)=>LoginPage(),
    HomePage.tag: (context)=>HomePage(),
    employee.tag: (context)=> employee(),
    absensiToday.tag: (context) =>absensiToday(),
    SplashScreenDepan.tag: (context) => SplashScreenDepan(),
  };

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {    
    return MaterialApp(
      title: 'Absensi',
      theme: ThemeData(
        primarySwatch: Colors.lightBlue,
      ),
      home: SplashScreenDepan(),
      routes: routes,
    );
  }
}

