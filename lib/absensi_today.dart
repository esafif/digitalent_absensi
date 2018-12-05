import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class absensiToday extends StatefulWidget {
  static String tag = 'absensi-today';

  @override
  absensiTodayState createState() {
    return new absensiTodayState();
  }
}

class absensiTodayState extends State<absensiToday> {
  var url = "http://418e8455.ngrok.io/";

  List datajson;
  Future<List> ambildata() async {
    final res = await http.get("${url}getabsensi");

    this.setState(() {
      datajson = json.decode(res.body);
    });
  }

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.ambildata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kehadiran"),
        backgroundColor: Colors.lightBlue[600],
      ),
      body: new ListView.builder(
        itemCount: datajson == null ? 0 : datajson.length,
        itemBuilder: (context, i) {
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
                              "${url}static/img/img_${datajson[i]['nip']}.jpeg",
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
                          Padding(
                            padding: new EdgeInsets.only(top: 10.0),
                          ),
                          new Text(
                            datajson[i]["nama"],
                            style: new TextStyle(
                                fontSize: 15.0, fontWeight: FontWeight.bold),
                          ),
                          new Text(
                            datajson[i]["jabatan"],
                            style: new TextStyle(fontSize: 13.0),
                          ),
                          new Text(
                            datajson[i]["tanggal"],
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
      ),
    );
  }
}
