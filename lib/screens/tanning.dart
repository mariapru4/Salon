import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/main_page.dart';

class Tanning extends StatefulWidget {
  static const String id = 'tanning';
  const Tanning({Key? key}) : super(key: key);

  @override
  _TanningState createState() => _TanningState();
}

class _TanningState extends State<Tanning> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Tanning'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        },
      )),
    );
  }
}
