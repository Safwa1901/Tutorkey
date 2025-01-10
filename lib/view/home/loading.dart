import 'dart:async';
import 'package:flutter_application_1/view/home/users/homewrapper.dart';
import 'package:flutter/material.dart';

class Loading extends StatefulWidget {
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {
  Color yl = Color(0xffF0C742);

  @override
  void initState() {
    super.initState();
    startTime(); // Ensure this is called to start the timer
  }

  // Timer to show loading screen for 5 seconds
  startTime() async {
    var duration = new Duration(seconds: 5);
    return new Timer(duration, route);
  }

  // Method to navigate to HomeWrapper after timer ends
  route() {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => HomeWrapper()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yl,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Center(
            child: Image.asset('assets/images/Splash Screen.png'), // Ensure the asset exists
          )
        ],
      ),
    );
  }
}
