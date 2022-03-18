// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/confirmation.dart';
import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/donor_portion/location/book_location/bookcurrent_location.dart';

import 'package:donor_app/donor_portion/location/book_location/booknext_location.dart';
import 'package:donor_app/donor_portion/location/food_location/foodcurrent_location.dart';
import 'package:donor_app/donor_portion/location/food_location/foodnext_location.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/details_screen.dart';
import 'package:donor_app/donor_portion/screens/end_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';

class Foods extends StatefulWidget {
  const Foods({Key? key}) : super(key: key);

  @override
  _FoodsState createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

  String dropdownvalue1 = 'Dairy';
  var language = [
    'Dairy',
    'Vegetable',
    'Lentils',
    'Oil',
    'Salt',
    'Mixture of many'
  ];

  int x = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("users")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInOrg = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  late String? email = loggedInOrg.email;
  late String? f_name = loggedInOrg.firstName;
  late String? s_name = loggedInOrg.secondName;
  late String? uid = loggedInOrg.uid;
  late String? phNumber = loggedInOrg.phNumber;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Food Screen"),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 130,
                    child: Image.asset("assets/food.png", fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Choose type:"),
                  DropdownButton(
                    value: dropdownvalue1,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: language.map((String language) {
                      return DropdownMenuItem(
                          value: language, child: Text(language));
                    }).toList(),
                    onChanged: (String? newValue1) {
                      setState(() {
                        dropdownvalue1 = newValue1!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Please choose Location to proceed:",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        x = 1;
                        Fluttertoast.showToast(msg: "Please press confirm now");
                        if (_formKey.currentState!.validate()) {
                          //write to database
                          /* Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => ClothesCurrentLocation(
                                  gender: dropdownvalue,
                                  
                                  email: email,
                                  f_name: f_name,
                                  s_name: s_name,
                                  uid: uid,
                                  age: dropdownvalue1,
                                )));*/

                          //goto location

                        }
                      },
                      icon: Icon(Icons.download),
                      label: Text("Current Location"),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 16, vertical: 13),
                          textStyle: TextStyle(fontSize: 18))),
                  SizedBox(
                    height: 15,
                  ),
                  ElevatedButton.icon(
                      onPressed: () {
                        x = 2;
                        Fluttertoast.showToast(msg: "Please press confirm now");
                      },
                      icon: Icon(Icons.next_plan),
                      label: Text("Next Location"),
                      style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                              horizontal: 27, vertical: 13),
                          textStyle: TextStyle(fontSize: 18))),
                  SizedBox(
                    height: 25,
                  ),
                  Text(
                    "Now Confirm the contribution:",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (x == 1) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodCurrentLocation(
                                email: email,
                                f_name: f_name,
                                type: dropdownvalue1,
                                s_name: s_name,
                                phNumber: phNumber,
                                uid: uid,
                                check: 0,
                              ),
                            ));
                      } else if (x == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => FoodNextLocation(
                                email: email,
                                f_name: f_name,
                                type: dropdownvalue1,
                                s_name: s_name,
                                phNumber: phNumber,
                                uid: uid,
                                check: 0,
                              ),
                            ));
                      } else {
                        Fluttertoast.showToast(msg: "Please press Location");
                      }
                    },
                    child: Text("Confirm"),
                    style: ElevatedButton.styleFrom(
                        padding:
                            EdgeInsets.symmetric(horizontal: 54, vertical: 13),
                        textStyle: TextStyle(fontSize: 25)),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: UserDrawer(),
    );
  }
}
