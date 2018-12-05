import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class employee extends StatefulWidget {
  static String tag = 'employee';
  _employeeState createState() => _employeeState();
}

class _employeeState extends State<employee> {
  var url = "http://418e8455.ngrok.io/";
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
                        onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                          builder: (BuildContext context) => new DetailHero(
                            nama: datajson[i]["nama"],
                            gambar: "${url}static/fp/${datajson[i]['nip']}.jpg",
                            jabatan: datajson[i]['jabatan'],
                            keterangan: datajson[i]['desk_kerja'],
                          )
                        )),
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

class DetailHero extends StatelessWidget {
  DetailHero({this.nama, this.gambar, this.jabatan, this.keterangan});
  final String nama;
  final String gambar;
  final String keterangan;
  final String jabatan;

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("$nama"),
        backgroundColor: Colors.grey[400],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            padding: new EdgeInsets.all(10.0),
            height: 240.0,
            child: new Hero(
              tag: nama,
              child: new Material(
                  child: new InkWell(
                child: new Image.network(
                  gambar,
                  fit: BoxFit.cover,
                ),
              )),
            ),
          ),
          new BagianNama(
            nama: nama,
            jabatan: jabatan,
          ),
          new BagianIcon(),
          new Keterangan(keterangan: keterangan),
        ],
      ),
    );
  }
}

class Keterangan extends StatelessWidget {
  Keterangan({this.keterangan});
  final String keterangan;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10.0),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: new Card(
          child: Text(
            keterangan,
            //"Avengers: Infinity War mendapat pujian dari banyak pemerhati film, yang memandang film ini sebagai kulminasi dari jagat sinematik Marvel. Pemerhati film di BBC Radio 1, Ali Plumb, menyanjung Infinity War sebagai",
            style: TextStyle(fontSize: 18.0),
            textAlign: TextAlign.justify,
          ),
        ),
      ),
    );
  }
}

class Iconteks extends StatelessWidget {
  Iconteks({this.icon, this.teks});
  final IconData icon;
  final String teks;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 45,
            color: Colors.blue,
          ),
          Text(
            teks,
            style: TextStyle(fontSize: 18.0, color: Colors.grey),
          )
        ],
      ),
    );
  }
}

class BagianIcon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: new EdgeInsets.all(10.0),
      child: Row(
        children: <Widget>[
          new Iconteks(icon: Icons.call, teks: "Call"),
          new Iconteks(icon: Icons.message, teks: "Message"),
          new Iconteks(icon: Icons.photo, teks: "Photo"),
        ],
      ),
    );
  }
}

class BagianNama extends StatelessWidget {
  BagianNama({this.nama, this.jabatan});
  final String nama;
  final String jabatan;

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(10.0),
        child: new Row(
          children: <Widget>[
            Expanded(
              child: new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  new Text(
                    nama,
                    style:
                        new TextStyle(fontSize: 20.0, color: Colors.blue[300]),
                  ),
                  new Text(
                    jabatan,
                    style: new TextStyle(fontSize: 17.0, color: Colors.grey),
                  )
                ],
              ),
            ),
            new Row(
              children: <Widget>[
                new Icon(
                  Icons.star,
                  size: 35.0,
                  color: Colors.blue,
                ),
                new Text(
                  "12",
                  style: new TextStyle(fontSize: 18.0),
                )
              ],
            )
          ],
        ));
  }
}