// ignore_for_file: prefer_const_constructors

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/eyebrow.dart';
import 'package:salon_booking_app/screens/face.dart';
import 'package:salon_booking_app/screens/hair.dart';
import 'package:salon_booking_app/screens/login.dart';
import 'package:salon_booking_app/screens/main_page.dart';
import 'package:salon_booking_app/screens/manicure_page.dart';
import 'package:salon_booking_app/screens/master_main_page.dart';
import 'package:salon_booking_app/screens/products.dart';
import 'package:salon_booking_app/screens/registration.dart';
import 'package:salon_booking_app/screens/splash.dart';
import 'package:salon_booking_app/screens/tanning.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyBP8gOHuBPbUnNGakU9fQXznN8ICMESy0o',
      appId: '1:135940368784:android:afea2fc27d79b2370a6b15',
      messagingSenderId: '448618578101',
      projectId: 'react-native-firebase-testing',
      databaseURL: 'https://salon-4c62f-default-rtdb.firebaseio.com',
      storageBucket: 'react-native-firebase-testing.appspot.com',
    ),
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: MySplashScreen.id,
      routes: {
        MySplashScreen.id: (context) => MySplashScreen(),
        Registration.id: (context) => Registration(),
        Login.id: (context) => Login(),
        MainPage.id: (context) => MainPage(),
        Master.id: (context) => Master(),
        Manicure.id: (context) => Manicure(),
        Tanning.id: (context) => Tanning(),
        Eyebrows.id: (context) => Eyebrows(),
        Hair.id: (context) => Hair(),
        Face.id: (context) => Face(),
        Products.id: (context) => Products(),
      },
    );
  }
}
