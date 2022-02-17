// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/colors.dart';
import 'package:salon_booking_app/screens/registration.dart';

class MySplashScreen extends StatefulWidget {
  static const String id = 'splash';
  @override
  _State createState() => _State();
}

class _State extends State<MySplashScreen> {
  startTimer() {
    Timer(const Duration(seconds: 10), () async {
      Navigator.push(
          context, MaterialPageRoute(builder: (c) => Registration()));
    });
  }

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      body: Column(
        children: [
          Container(
            width: 100,
            height: 50,
            margin: EdgeInsets.only(top: 40),
            decoration: BoxDecoration(
                image:
                    DecorationImage(image: AssetImage('asset/image/logo.png'))),
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Live, laugh and beauty",
            style: TextStyle(
                fontSize: 40, color: Colors.white, fontWeight: FontWeight.w900),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 30,
          ),
          Text(
            "Book Service At The Comfort \nOf Your Home",
            style: TextStyle(
              fontSize: 18,
              color: Colors.white,
              fontWeight: FontWeight.w400,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(
            height: 60,
          ),
          Container(
            height: 350,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('../images/pedicure.png'),
                    fit: BoxFit.cover)),
          ),
          
      
        ],
      ),
    );
  }
}
