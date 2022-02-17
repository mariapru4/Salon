// ignore_for_file: deprecated_member_use, use_key_in_widget_constructors, unnecessary_new, prefer_const_constructors, unnecessary_import, sized_box_for_whitespace, unused_import, avoid_print

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:salon_booking_app/screens/main_page.dart';
import 'package:salon_booking_app/screens/master_main_page.dart';
import 'package:salon_booking_app/screens/registration.dart';
import 'package:salon_booking_app/widgets/progress_dialog.dart';

class Login extends StatefulWidget {
  static const String id = 'login';

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  void showSnackBar(String title) {
    final snackbar = SnackBar(
      content: Text(
        title,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 15),
      ),
    );
    scaffoldKey.currentState?.showSnackBar(snackbar);
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;

  var emailController = TextEditingController();

  var passwordController = TextEditingController();

  void login() async {
    //show please wait dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) => ProgressDialog(
        status: 'Logging you in',
      ),
    );

    final user = (await _auth
            .signInWithEmailAndPassword(
      email: emailController.text,
      password: passwordController.text,
    )
            .catchError((ex) {
      //check error and display message
      Navigator.pop(context);
      showSnackBar(ex.message);
    }))
        .user;
    if (user != null) {
      // verify login

      DatabaseReference userRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');

      userRef.get().then((DataSnapshot snapshot) => {
            if (snapshot.child('role').value == 'Master')
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, Master.id, (route) => false)
              }
            else
              {
                Navigator.pushNamedAndRemoveUntil(
                    context, MainPage.id, (route) => false)
              }
          });
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      // ignore: prefer_const_literals_to_create_immutables
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(children: [
              SizedBox(
                height: 70,
              ),
              Image(
                alignment: Alignment.center,
                height: 200.0,
                width: 200.0,
                image: AssetImage('../images/logo.png'),
              ),
              SizedBox(
                height: 40,
              ),
              Text(
                'Sign In ',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Email address',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: 'Password',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    MaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25)),
                      color: Colors.purple,
                      textColor: Colors.white,
                      onPressed: () async {
                        // check network awayvilatility
                        var connectivityResult =
                            await Connectivity().checkConnectivity();
                        if (connectivityResult != ConnectivityResult.mobile &&
                            connectivityResult != ConnectivityResult.wifi) {
                          showSnackBar('No internet connectivity');
                        }

                        if (!emailController.text.contains('@')) {
                          showSnackBar('Please provide a valid email');
                          return;
                        }

                        if (passwordController.text.length < 8) {
                          showSnackBar(
                              'Password must be at least 8 characters');
                          return;
                        }
                        login();
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        child: Center(
                          child: Text(
                            "LOGIN",
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                      context, Registration.id, (route) => false);
                },
                child: Text('Don\'t have an a account, sign up here'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
