import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/main_page.dart';

class Face extends StatefulWidget {
  static const String id = 'face';
  const Face({ Key? key }) : super(key: key);

  @override
  _FaceState createState() => _FaceState();
}

class _FaceState extends State<Face> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Face'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        },
      )),
    );
  }
}