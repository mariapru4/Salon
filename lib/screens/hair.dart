import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/main_page.dart';

class Hair extends StatefulWidget {
  static const String id = 'hair';

  const Hair({Key? key}) : super(key: key);

  @override
  _HairState createState() => _HairState();
}

class _HairState extends State<Hair> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Hair'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        },
      )),
    );
  }
}
