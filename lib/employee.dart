import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class employee extends StatefulWidget {
  static String tag = 'employee';
  _employeeState createState() => _employeeState();
}

class _employeeState extends State<employee> {
  var url = "http://04ce791f.ngrok.io/";
  List<Container> daftarEmployee = new List();

  List datajson;
  Future<List> ambildata() async {
    final hasil = await http.get(
      "${url}getpegawai",
    );

    this.setState(() {
      datajson = json.decode(hasil.body);
    });
  }

@override
  void initState() {
    this.ambildata();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Data Employee"),
          backgroundColor: Colors.lightBlue[600],
        ),
        body: new ListView.builder(
          itemCount: datajson == null ? 0 : datajson.length,
          itemBuilder: (context, i){
            return new Container(
              child: new Card(
          child: new Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Padding(
                    padding: new EdgeInsets.all(5.0),
                  ),
                  new Hero(
                    tag: datajson[i]["nip"],
                    child: new Material(
                      child: new InkWell(
                        onTap: () {},
                        child: new Image.network(
                          "${url}static/fp/${datajson[i]['nip']}.jpg",
                          height: 120.0,
                          width: 100.0,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                  new Padding(
                    padding: new EdgeInsets.fromLTRB(10.0, 10.0, 5.0, 10.0),
                  ),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding (padding: new EdgeInsets.only(top: 10.0),),
                      new Text(
                        datajson[i]["nama"],
                        style: new TextStyle(
                            fontSize: 15.0, fontWeight: FontWeight.bold),
                      ),
                      new Text(
                        datajson[i]["jabatan"],
                        style: new TextStyle(fontSize: 13.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
            );
          },
        ));
  }
}
