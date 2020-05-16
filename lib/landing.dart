import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'scan.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingScreen extends StatefulWidget {
  @override
  _LandingState createState() => new _LandingState();
}

class _LandingState extends State<LandingScreen> {
  final List<String> _stations = [
    "Bengaluru(BLR)",
    "Mumbai(BOM)",
    "Chennai(MAA)",
    "Hyderabad(HYD)",
    "Kolkata(CCU)",
    "Los Angeles(LAX)",
    "Chicago(ORD)",
    "Dallas(DFW)",
    "New York(JFK)",
    "London-Heathrow(LHR)",
    "London-Gatwick(LGW)",
    "London City(LCY)",
    "Manchester(MAN)",
    "Birmingham(BHX)"
  ];

  String _station;

  @override
  void initState() {
    super.initState();
    _station = _stations.first;
  }

  @override
  Widget build(BuildContext context) {
    final textView = Text(
      "Select Station:",
      style: TextStyle(
          fontSize: 18.0, fontFamily: 'vag_rounded', color: Colors.grey),
    );

    final dropDown1 = DropdownButton(
      hint: Text(
        'Select Station:',
        style: TextStyle(fontSize: 20.0, fontFamily: 'vag_rounded'),
      ),
      value: _station,
      onChanged: (String newValue) => {
        setState(() {
          this._station = newValue;
        }),
      },
      items: _stations.map((String location) {
        return new DropdownMenuItem(
          value: location,
          child: new Text(
            location,
            style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'vag_rounded'),
          ),
        );
      }).toList(),
    );

    final button = RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      splashColor: Colors.blueGrey,
      onPressed: next,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              Text(
                'N E X T',
                style: TextStyle(fontSize: 18.0, fontFamily: 'vag_rounded'),
              ),
            ],
          )
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: new Text(
            'Baggage Management System',
            style: TextStyle(fontFamily: 'vag_rounded'),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.all(36.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 15.0,
                    ),
                    textView,
                    SizedBox(
                      height: 10.0,
                    ),
                    dropDown1,
                    SizedBox(
                      height: 25.0,
                    ),
                    button,
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }

  void createDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Barcode Text"),
            //content: Text(barcode),
          );
        });
  }

  Future<void> next() async {
   // print(_station);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString("city", _station);

    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScanScreen()));
  }
}
