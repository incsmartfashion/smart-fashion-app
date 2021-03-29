import 'dart:async';

import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({Key key, this.title}) : super(key: key);
  final String title; 
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  startTime() async {
    var _duration = new Duration(seconds: 5);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage() {
  Navigator.of(context).pushReplacementNamed('/homescreen');
}
@override
void initState() {
  super.initState();
  startTime();
}
  @override
  Widget build(BuildContext context) {
  return new Scaffold(
    backgroundColor: Colors.green[200],
    body: new Center(
      child: new Image.asset('assets/icon/smartfashion.png',height: 150,),
    ),
  );
  }

}