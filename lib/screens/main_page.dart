// ignore_for_file: deprecated_member_use, unused_local_variable, prefer_const_constructors, unnecessary_new, use_function_type_syntax_for_parameters, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:salon_booking_app/screens/colors.dart';
import 'package:salon_booking_app/screens/eyebrow.dart';
import 'package:salon_booking_app/screens/face.dart';
import 'package:salon_booking_app/screens/hair.dart';
import 'package:salon_booking_app/screens/login.dart';
import 'package:salon_booking_app/screens/manicure_page.dart';
import 'package:salon_booking_app/screens/products.dart';
import 'package:salon_booking_app/screens/tanning.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';

class MainPage extends StatefulWidget {
  static const String id = 'main_page';

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  String selectedType = "initial";
  String selectedFrequency = "monthly";
  final FirebaseAuth _auth = FirebaseAuth.instance;
  late User user;

  @override
  void initState() {
    super.initState();
    initUser();
  }

  initUser() async {
    user = _auth.currentUser!;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: purple,
      appBar: AppBar(
        title: Text(
          "Your Plan",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
    

      drawer: new Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              color: purple,
              child: UserAccountsDrawerHeader(
                accountName: Text("${user.displayName}"),
                accountEmail: Text("${user.email}"),
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('../icons/user.png'),
                    
                  ),
                ),
              ),
            ),
            SizedBox(height: 10,),
            ListTile(
              leading: Icon(Icons.favorite),
              title: Text('Favorites'),
              onTap: () => {},
            ),
            ListTile(
              leading: Icon(Icons.shop),
              title: Text('My Booking'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.share),
              title: Text('Share'),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.notifications),
              title: Text('Request'),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () => null,
            ),
            ListTile(
              leading: Icon(Icons.description),
              title: Text('Description'),
              onTap: () => null,
            ),
            Divider(),
            ListTile(
              title: Text('Exit'),
              leading: Icon(Icons.exit_to_app),
              onTap: () => null,
            ),
          ],
        ),
      ),

      // ignore: unnecessary_new

      body: Column(
        children: [
          Expanded(
            child: Container(
              width: MediaQuery.of(context).size.width,
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40)),
                  color: Colors.white),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  Text(
                    "Selected Serivce",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          changeCleaningType("initial");
                        },
                        child: Column(
                          children: [
                            Container(
                              height: 140,
                              width: MediaQuery.of(context).size.width * 0.9,
                              decoration: BoxDecoration(
                                color: Color(0xffdfdeff),
                                image: DecorationImage(
                                  image: AssetImage('../images/pedicure.png'),
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              "Service Coupon",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    'Selected Serivce',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      extraWidget("nail-polish", "Manicure"),
                      extraWidget("eyebrow", "Eyebrows"),
                      extraWidget("salon", "Hair Style"),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      extraWidget("beauty-treatment", "Face"),
                      extraWidget("sunbed", "Tanning"),
                      extraWidget("hair-comb", "Products"),
                    ],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  void getUserName(String username) {
    username = username;
    setState(() {});
  }

  void changeCleaningType(String type) {
    selectedType = type;
    setState(() {});
  }

  void changeFrequency(String frequency) {
    selectedFrequency = frequency;
    setState(() {});
  }

  Column extraWidget(String img, String name) {
    return Column(
      children: [
        InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(builder: (context) {
                switch (name) {
                  case 'Manicure':
                    return Manicure();
                    break;
                  case 'Eyebrows':
                    return Eyebrows();
                    break;
                  case 'Hair Style':
                    return Hair();
                    break;
                  case 'Face':
                    return Face();
                    break;
                  case 'Tanning':
                    return Tanning();
                    break;
                  case 'Products':
                    return Products();
                    break;

                  default:
                    return MainPage();
                }
              }));
            },
            child: Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: purple,
              ),
              child: Container(
                margin: EdgeInsets.all(17),
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('../icons/$img.png'),
                        fit: BoxFit.contain)),
              ),
            ))
      ],
    );
  }

  void openCalendarPage() {
    Navigator.pushNamed(context, '/CalendarPage');
  }

}
