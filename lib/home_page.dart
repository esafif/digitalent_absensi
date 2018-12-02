import 'package:flutter/material.dart';
import 'package:digitalent_absensi/employee.dart';
import 'package:digitalent_absensi/absensi_today.dart';
import 'package:digitalent_absensi/log_absensi.dart';
import 'package:digitalent_absensi/notify.dart';

class HomePage extends StatelessWidget {
  static String tag = 'home-page';

  final btnAbsen = RawMaterialButton(
    onPressed: () {},
    child: new Icon(
      Icons.alarm_on,
      color: Colors.grey[800],
      size: 100.0,
    ),
    shape: new CircleBorder(),
    elevation: 2.0,
    fillColor: Colors.orange[300],
    padding: const EdgeInsets.all(35.0),
  );

  final iconDepan = Container(
    padding: EdgeInsets.only(top: 30.0),
    child:Row(
      children: <Widget>[
        new Iconteks(icon: Icons.people, teks: "Absen Today", route: new absensiToday(),),
        new Iconteks(icon: Icons.timeline, teks: "Log Absen",route: new logAbsensi()),
        new Iconteks(icon: Icons.notifications, teks: "Notification", route: new notifyAbsen()),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //Ini bagian AppBar
      appBar: AppBar(
        title: Text("Absensi Project"),
        backgroundColor: Colors.lightBlue[600],
      ),

      //Ini bagian drawer
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            new UserAccountsDrawerHeader(
              accountName: Text(
                "Fiflaren",
                style: TextStyle(color: Colors.white),
              ),
              accountEmail: Text("esafif637@gmail.com",
                  style: TextStyle(color: Colors.white)),
              currentAccountPicture: new GestureDetector(
                onTap: () {
                  //need your logic
                },
                child: new CircleAvatar(
                  backgroundImage: new NetworkImage(
                      "https://gfx-bloggar.aftonbladet-cdn.se/wp-content/blogs.dir/430/files/2014/08/fifflaren-672x336.jpg"),
                ),
              ),
              decoration: new BoxDecoration(
                  image: new DecorationImage(
                      image: new NetworkImage(
                          "https://png.pngtree.com/thumb_back/fw800/back_pic/04/43/89/3458538e62581d8.jpg"),
                      fit: BoxFit.cover)),
            ),
            new ListTile(
              onTap: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> new employee())),
              title: Text("Employee"),
              trailing: Icon(Icons.people),
            ),
            new ListTile(
              title: Text("Sign Out"),
              trailing: Icon(Icons.power_settings_new),
            ),
          ],
        ),
      ),

      body: Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: FractionalOffset.topCenter,
                end: FractionalOffset.bottomCenter,
                colors: [Colors.lightBlue[700], Colors.white30])),
        child: Center(
          child: ListView(
            shrinkWrap: true,
            padding: EdgeInsets.only(left: 24.0, right: 24.0),
            children: <Widget>[
              btnAbsen,
              iconDepan,
            ],
          ),
        ),
      ),
    );
  }
}

class Iconteks extends StatelessWidget {
  Iconteks({this.icon, this.teks, this.route});
  final IconData icon;
  final String teks;
  final route;

  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: ()=> Navigator.of(context).push(MaterialPageRoute(builder: (BuildContext context)=> route)),
      child: Column(
        children: <Widget>[
          Icon(
            icon,
            size: 50.0,
            color: Colors.grey[800],
          ),
          Text(
            teks,
            style: TextStyle(fontSize: 13.0, color: Colors.grey[800]),
          ),
        ],
      ),
    );
  }
}
