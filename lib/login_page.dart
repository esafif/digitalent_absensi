import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:digitalent_absensi/home_page.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  static String tag = 'login-page';
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var url = "http://04ce791f.ngrok.io/";

  SharedPreferences pref;
  //ctrl textfield
  TextEditingController ctrEmail = new TextEditingController();
  TextEditingController ctrPass = new TextEditingController();

  Future<List> _login() async {
    //Map<String, String> headers = new Map<String, String>();
    //headers["Content-type"] = "application/json";
    //headers["Accept"] = "application/json";
    //String str = '{"email":"${ctrEmail.text}", "password","${ctrPass.text}"}';

    final res = await http.post(
      "${url}login",
      body: {
        "email":ctrEmail.text,
        "password":ctrPass.text
      },
    );

    //final resget = await http.get("http://978952d9.ngrok.io/getpegawai");
    var datauser = json.decode(res.body);
   
    if (datauser.length == 0) {
      setState(() {
        _alertdialog("Akun tidak terdaftar");
      });
    } else {
      List<Pegawai> listpegawai= [];   
      for(var u in datauser){
        Pegawai peg = Pegawai(u['nip'], u['nama'], u['alamat'], u['jabatan'], u['desk_kerja'], u['jenis_kelamin'], u['status_absen'], u['email'], u['password']);
        listpegawai.add(peg);
      }

      String nipInstance =  listpegawai[0].nip.toString();
      String namaInstance = listpegawai[0].nama.toString();
      String emailInstance = listpegawai[0].email.toString();

      pref = await SharedPreferences.getInstance();
      pref.setString("nip", nipInstance);
      pref.setString("nama", namaInstance);
      pref.setString("email", emailInstance);
      pref.setString("url", url);
      pref.commit();

      Navigator.pushReplacementNamed(context, HomePage.tag);
    }
  }

  void _alertdialog(String str) {
    if (str.isEmpty) return;

    AlertDialog alertDialog = new AlertDialog(
      content: new Text(
        str,
        style: new TextStyle(fontSize: 20.0),
      ),
      actions: <Widget>[
        new RaisedButton(
          color: Colors.lightBlue[400],
          child: new Text("Ok", style: new TextStyle(color: Colors.black),),
          onPressed: (){
            Navigator.pop(context);
          },
        )
      ],
    );
    showDialog(context: context, child: alertDialog);
  }

  @override
  Widget build(BuildContext context) {
    final logo = Hero(
      tag: 'logo-log',
      child: Image.asset('img/logo.png', fit: BoxFit.cover),
    );

    final email = TextFormField(
      controller: ctrEmail,
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      decoration: InputDecoration(
        hintText: 'Email',
        labelText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 12.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );

    final password = TextFormField(
      controller: ctrPass,
      autofocus: false,
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        labelText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(15.0)),
      ),
    );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () {
            _login();
            //Navigator.of(context).pushNamed(HomePage.tag);
          },
          color: Colors.lightBlueAccent,
          child: Text("Log In", style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text("Forgot password?", style: TextStyle(color: Colors.black54)),
      onPressed: () {
        // need the logic dude
      },
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topRight,
                end: FractionalOffset.bottomLeft,
                colors: [Colors.lightBlue[400], Colors.white70])),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              logo,
              SizedBox(
                height: 1.0,
              ),
              email,
              SizedBox(
                height: 9.0,
              ),
              password,
              SizedBox(
                height: 20.0,
              ),
              loginButton,
              forgotLabel
            ],
          ),
        ),
      ),
    );
  }
}

class Pegawai {
  final int nip;
  final String nama;
  final String alamat;
  final String jabatan;
  final String desk_kerja;
  final String jenis_kelamin;
  final int status_absen;
  final String email;
  final String password;

  Pegawai(this.nip, this.nama, this.alamat, this.jabatan, this.desk_kerja, this.jenis_kelamin, this.status_absen, this.email, this.password);
}