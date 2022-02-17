import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/main_page.dart';

class Eyebrows extends StatefulWidget {
  static const String id = 'eyebrow';

  const Eyebrows({Key? key}) : super(key: key);

  @override
  _EyebrowsState createState() => _EyebrowsState();
}

class _EyebrowsState extends State<Eyebrows> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Eyebrow'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        },
      )),
    );
  }
}
