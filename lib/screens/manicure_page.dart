import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/login.dart';
import 'package:salon_booking_app/screens/main_page.dart';

class Manicure extends StatefulWidget {
  static const String id = 'manicure_page';
  const Manicure({Key? key}) : super(key: key);

  @override
  _ManicureState createState() => _ManicureState();
}

class _ManicureState extends State<Manicure> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('welcome'),
      ),
      body: Center(
          child: ElevatedButton(
        child: const Text('Manicure'),
        onPressed: () {
          Navigator.pushNamedAndRemoveUntil(
              context, MainPage.id, (route) => false);
        },
      )),
    );
  }
}
