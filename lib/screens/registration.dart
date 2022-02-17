// ignore_for_file: prefer_const_constructors, unused_local_variable, avoid_print, sized_box_for_whitespace, deprecated_member_use, non_constant_identifier_names, unused_field, unnecessary_new, use_key_in_widget_constructors, unused_import

import 'dart:io';

import 'package:connectivity/connectivity.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/login.dart';
import 'package:salon_booking_app/screens/main_page.dart';
import 'package:salon_booking_app/screens/master_main_page.dart';

import '../widgets/progress_dialog.dart';

class Registration extends StatefulWidget {
  static const String id = 'registration';

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final GlobalKey<ScaffoldState> scaffoldKey = new GlobalKey<ScaffoldState>();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Initial Selected Value
  String dropdownvalue = 'Master';

  // List of items in our dropdown menu
  var roles = [
    'Master',
    'Customer',
  ];

  //Controllers
  var fullNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var phoneController = TextEditingController();
  var roleController = TextEditingController();

//showSnackBar

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

  void registerUser() async {
    //show a wait dialog
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) =>
            ProgressDialog(status: 'Registering you '));

    final user = (await _auth
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text)
            .catchError((ex) {
      Navigator.pop(context);
      showSnackBar(ex.message);
    }))
        .user;

    Navigator.pop(context);

    // check if user registration is successful
    if (user != null) {
      DatabaseReference newUserRef =
          FirebaseDatabase.instance.reference().child('users/${user.uid}');
      //Prepare data to be saved on users table
      Map userMap = {
        'email': emailController.text,
        'password': passwordController.text,
        'role': dropdownvalue,
      };
      newUserRef.set(userMap);

      if (dropdownvalue != 'Master') {
        DatabaseReference newCustomerRef =
            FirebaseDatabase.instance.reference().child('customer/${user.uid}');

        //Prepare data to be saved on users table
        Map customerMap = {
          'full_name': fullNameController.text,
          'phone': phoneController.text,
          'email': emailController.text,
          'password': passwordController.text,
          'role': dropdownvalue,
        };
        newCustomerRef.set(customerMap);

        //Take the user to the MainPage
        Navigator.pushNamedAndRemoveUntil(
            context, MainPage.id, (route) => false);
      } else {
        DatabaseReference newMasterRef =
            FirebaseDatabase.instance.reference().child('masters/${user.uid}');

        //Prepare data to be saved on masters table
        Map masterMap = {
          'full_name': fullNameController.text,
          'email': emailController.text,
          'phone': passwordController.text,
          'password': passwordController.text,
          'role': dropdownvalue,
        };
        newMasterRef.set(masterMap);

        //Take the user to the MasterMainPage
        Navigator.pushNamedAndRemoveUntil(context, Master.id, (route) => false);
      }
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
                'Sign Up ',
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
                      controller: fullNameController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                          labelText: 'Full name',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14),
                    ),

                    SizedBox(
                      height: 10,
                    ),
                    //Full Name
                    TextField(
                      controller: emailController,
                      keyboardType: TextInputType.name,
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

                    //Phone
                    TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                          labelText: 'Phone number',
                          labelStyle: TextStyle(fontSize: 14),
                          hintStyle:
                              TextStyle(color: Colors.grey, fontSize: 10.0)),
                      style: TextStyle(fontSize: 14),
                    ),

                    SizedBox(
                      height: 10,
                    ),

                    //Password
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

                    DropdownButton(

                        // Initial Value
                        value: dropdownvalue,

                        // Down Arrow Icon
                        icon: const Icon(Icons.keyboard_arrow_down),

                        // Array list of items
                        items: roles.map((String items) {
                          return DropdownMenuItem(
                            value: items,
                            child: Text(items),
                          );
                        }).toList(),
                        // After selecting the desired option,it will
                        // change button value to selected value
                        onChanged: (String? newValue) {
                          setState(() {
                            dropdownvalue = newValue!;
                          });
                        }),

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

                        if (fullNameController.text.length < 3) {
                          showSnackBar('Please provide a valid fullname');
                          return;
                        }

                        if (phoneController.text.length < 10) {
                          showSnackBar('Please provide a valid phone number');
                          return;
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

                        registerUser();
                      },
                      child: Container(
                        height: 30,
                        width: 120,
                        child: Center(
                          child: Text(
                            "REGISTER",
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
                      context, Login.id, (route) => false);
                },
                child: Text('Already have a account? LOGIN'),
              )
            ]),
          ),
        ),
      ),
    );
  }
}
