import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/foundation.dart';
import 'package:flutterapp/scan.dart';

import 'landing.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Login'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextStyle style =
      TextStyle(fontFamily: 'vag_rounded', fontSize: 20.0);

  var emailController = new TextEditingController();

  var passwordController = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    final titleText = new Text(
      "Baggage Management System",
      style: new TextStyle(
        color: Colors.black,
        fontStyle: FontStyle.normal,
        fontWeight: FontWeight.bold,
        fontFamily: 'vag_rounded',
        fontSize: 18.0,
      ),
      textScaleFactor: 1.0,
    );

    final emailField = TextField(
        controller: emailController,
        obscureText: false,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Username",
          hintStyle: TextStyle(fontSize: 18.0, fontFamily: "vag_rounded"),
          border: OutlineInputBorder(),
          suffixIcon: new Icon(Icons.person),
          labelText: "Username",
          labelStyle: TextStyle(fontSize: 18.0, fontFamily: "vag_rounded"),
          //errorText: validateEmail(emailController.text),
        ));

    final passwordField = TextField(
        controller: passwordController,
        obscureText: true,
        style: style,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
          hintText: "Password",
          hintStyle: TextStyle(fontSize: 18.0, fontFamily: "vag_rounded"),
          border: OutlineInputBorder(),
          suffixIcon: new Icon(Icons.visibility_off),
          labelText: "Password",
          labelStyle: TextStyle(fontSize: 18.0, fontFamily: "vag_rounded"),
        ));

    final loginButon = Material(
      elevation: 5.0,
      //borderRadius: BorderRadius.circular(30.0),
      color: Colors.blue, //0xff01A0C7
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width,
        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
        onPressed: () => {inviteClicked()},
        child: Text("Login",
            textAlign: TextAlign.center,
            style: style.copyWith(
                fontSize: 20.0, fontFamily: "vag_rounded",
                color: Colors.white, fontWeight: FontWeight.bold)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
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
                  child: new Image.asset(
                    "assets/logo.png",
                    width: 51,
                    height: 50,
                  ),
                ),
                SizedBox(
                  height: 25.0,
                ),
                titleText,
                SizedBox(height: 25.0),
                emailField,
                SizedBox(height: 25.0),
                passwordField,
                SizedBox(
                  height: 25.0,
                ),
                loginButon,
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

  inviteClicked() {
    FocusScope.of(context).requestFocus(FocusNode());
    var email = emailController.text;
    var password = passwordController.text;

    debugPrint("password " + password);

    if (email.length == 0 || password.length == 0) {
      Fluttertoast.showToast(
          msg: "Username/Password can't be empty",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0);
    } else {
      if (email == "test" && password == "1234") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => LandingScreen()),
        );
      } else {
        Fluttertoast.showToast(
            msg: "Invalid Username/Password.",
            toastLength: Toast.LENGTH_SHORT,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
    }
  }

  validateEmail(text) {
    if (!text.isNotEmpty) {
      return "Password can't be empty.";
    }
    return null;
  }

  /*@override
  void dispose() {
    _text.dispose();
    super.dispose();
  }*/
}
