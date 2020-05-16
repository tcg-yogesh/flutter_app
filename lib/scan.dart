import 'dart:async';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ScanScreen extends StatefulWidget {
  @override
  _ScanState createState() => new _ScanState();
}

class _ScanState extends State<ScanScreen> {
  String barcode = "";

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

  List<String> _locations;

  String _location, _station;

  // List<String> _locations;

  // Declare this variable
  int selectedRadioTile;
  int selectedRadio;

  @override
  void initState() {
    super.initState();
    //_location = _locations.first;
    //_station = _stations.first;
    selectedRadioTile = 0;
    selectedRadio = 0;
    setLocations(1);
  }

  @override
  Widget build(BuildContext context) {
    final textView = Text(
      "Location:",
      style: TextStyle(
          fontSize: 18.0, fontFamily: 'vag_rounded', color: Colors.grey),
    );

    final dropDown = DropdownButton(
      hint: Text(
        'Select location',
        style: TextStyle(fontSize: 18.0, fontFamily: 'vag_rounded'),
      ),
      value: _location,
      onChanged: (String newValue) => {
        setState(() {
          this._location = newValue;
        }),
      },
      items: _locations.map((String location) {
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

    final dropDown1 = DropdownButton(
      hint: Text(
        'Select Station',
        style: TextStyle(fontSize: 18.0, fontFamily: 'vag_rounded'),
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
                fontSize: 14.0,
                fontWeight: FontWeight.bold,
                fontFamily: 'vag_rounded'),
          ),
        );
      }).toList(),
    );

    var radios = Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          "Select Mode:",
          style: TextStyle(
              fontSize: 18.0,
              fontFamily: 'vag_rounded',
              color: Colors.grey,
              fontWeight: FontWeight.bold),
        ),
        RadioListTile(
          value: 1,
          groupValue: selectedRadioTile,
          title: Text(
            "Arrival",
            style: new TextStyle(
              fontSize: 18.0,
              fontFamily: 'vag_rounded',
              fontWeight: FontWeight.bold,
            ),
          ),
          onChanged: (val) {
            print("$val");
            setSelectedRadioTile(val);
          },
          activeColor: Colors.blue,
          selected: true,
        ),
        RadioListTile(
          value: 2,
          groupValue: selectedRadioTile,
          title: Text(
            "Departure",
            style: new TextStyle(
              fontSize: 18.0,
              fontFamily: 'vag_rounded',
              fontWeight: FontWeight.bold,
            ),
          ),
          onChanged: (val) {
            print("$val");
            setSelectedRadioTile(val);
          },
          activeColor: Colors.blue,
          selected: false,
        ),
        RadioListTile(
          value: 3,
          groupValue: selectedRadioTile,
          title: Text(
            "Interim",
            style: new TextStyle(
              fontSize: 18.0,
              fontFamily: 'vag_rounded',
              fontWeight: FontWeight.bold,
            ),
          ),
          onChanged: (val) {
            print("$val");
            setSelectedRadioTile(val);
          },
          activeColor: Colors.blue,
          selected: false,
        ),
      ],
    );

    final button = RaisedButton(
      color: Colors.blue,
      textColor: Colors.white,
      splashColor: Colors.blueGrey,
      onPressed: scan,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Icon(
            Icons.camera_alt,
            size: 40,
          ),
          SizedBox(
            width: 10,
          ),
          Column(
            children: <Widget>[
              Text(
                'Scan Barcode',
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
                    radios,
                    SizedBox(
                      height: 15.0,
                    ),
                    textView,
                    SizedBox(
                      height: 15.0,
                    ),
                    dropDown,
                    SizedBox(
                      height: 25.0,
                    ),
                    //dropDown1,
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

  Future scan() async {

    final prefs = await SharedPreferences.getInstance();
    String city = prefs.getString("city");

    try {
      String barcode = await BarcodeScanner.scan();
      setState(() {
        this.barcode = barcode;
        print("barcode " + barcode);
        createDialog(barcode);
      });
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied)
        setState(() {
          this.barcode = 'Camera Permission not granted';
        });
    }
  }

  setSelectedRadioTile(int val) {
    setState(() {
      selectedRadioTile = val;
      setLocations(selectedRadioTile);
    });
  }

  void createDialog(String barcode) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Barcode Text"),
            content: Text(barcode),
          );
        });
  }

  void setLocations(int selectedRadioTile) {
    switch (selectedRadioTile) {
      case 1:
        _locations = ["Baggage Office", "Claim", "TSA", "Back Room"];
        break;

      case 2:
        _locations = ["Ramp", "TSA", "City Office", "Transfer desk"];
        break;

      case 3:
        _locations = ["Ramp", "Baggage Office", "Transfer desk"];
        break;

      default:
        _locations = [
          "Ramp",
          "Baggage Office",
          "Collection Point",
          "Back Office"
        ];
        break;
    }
  }
}
