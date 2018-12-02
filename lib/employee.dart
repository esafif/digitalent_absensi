import 'package:flutter/material.dart';

class employee extends StatefulWidget {
  static String tag = 'employee';
  _employeeState createState() => _employeeState();
}

class _employeeState extends State<employee> {
  List<Container> daftarEmployee = new List();

  var employee = [
    {"nama": "Ichsan", "foto": "ichsan.jpg", "jabatan": "AI ENGINEER"},
    {"nama": "Ihsan", "foto": "ihsan.jpg", "jabatan": "UI/UX"}
  ];

  _listEmployee() async {
    for (var i = 0; i < employee.length; i++) {
      final emp = employee[i];
      final String foto = emp["foto"];

      daftarEmployee.add(new Container(
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
                    tag: emp['nama'],
                    child: new Material(
                      child: new InkWell(
                        onTap: () {},
                        child: new Image.asset(
                          "img/$foto",
                          height: 140.0,
                          width: 120.0,
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
                      new Text(
                        emp['nama'],
                        style: new TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                      ),
                      new Text(
                        emp['jabatan'],
                        style: new TextStyle(fontSize: 12.0),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ));
    }
  }

  void initState() {
    _listEmployee();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: new AppBar(
          title: Text("Data Employee"),
          backgroundColor: Colors.lightBlue[600],
        ),
        body: new ListView(
          children: daftarEmployee,
        ));
  }
}
