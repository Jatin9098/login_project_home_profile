import 'dart:async';
import 'package:flutter/material.dart';
import 'package:test_sample/login_screen.dart';
import 'package:flutter/services.dart';


void main() => runApp(new MaterialApp(
  home: new SpalshScreen(),
  routes: < String , WidgetBuilder>{
     '/HomeScreen':(BuildContext context) => new HomeScreen(),
    
  },
//   routes: <String, WidgetBuilder>{
//  '/Second': (BuildContext context) => new SecondScreen(),
//   },

    
));

class SpalshScreen extends StatefulWidget {
  @override
  _SpalshScreenState createState() => _SpalshScreenState();
}

class _SpalshScreenState extends State<SpalshScreen> {
  
  @override
  void initState(){
    super.initState();
    this.startTime();
  }

  startTime() async{
    var _duration = new Duration(seconds: 3);
    return new Timer(_duration, navigationPage);
  }

  void navigationPage(){
    Navigator.of(context).pushReplacementNamed('/HomeScreen');
  }
  @override
  Widget build(BuildContext context) {

    /*for working only portrait mode*/
    SystemChrome.setPreferredOrientations(
      [
        DeviceOrientation.portraitDown,
        DeviceOrientation.portraitUp
      ]
    );
    return Container(
       child: new Image(
          image: AssetImage("assets/splash.png"),
          fit: BoxFit.cover,
    ),
    );
  }
}
