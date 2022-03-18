// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/confirmation.dart';
import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/donor_portion/location/book_location/bookcurrent_location.dart';

import 'package:donor_app/donor_portion/location/book_location/booknext_location.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/details_screen.dart';
import 'package:donor_app/donor_portion/screens/end_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';

class Books extends StatefulWidget {
  const Books({Key? key}) : super(key: key);

  @override
  _BooksState createState() => _BooksState();
}

class _BooksState extends State<Books> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

  String dropdownvalue1 = 'English';
  var language = ['English', 'Nepalese', 'Both', 'Other'];

  String dropdownvalue2 = '<5';
  var numbers = ['<5', '5-10', '>10', '10-20', '>20'];

  String dropdownvalue3 = 'Novel';
  var category = [
    'Novel',
    'Courses',
    'Poem',
    'Comics',
    'Financial',
    'Religious'
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

  late String lang;
  late String numb;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Book Screen"),
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
                    child: Image.asset("assets/books.png", fit: BoxFit.contain),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Choose languge:"),
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
                  Text("Choose number of books:"),
                  DropdownButton(
                    value: dropdownvalue2,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: numbers.map((String numbers) {
                      return DropdownMenuItem(
                          value: numbers, child: Text(numbers));
                    }).toList(),
                    onChanged: (String? newValue2) {
                      setState(() {
                        dropdownvalue2 = newValue2!;
                      });
                    },
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Text("Choose Category:"),
                  DropdownButton(
                    value: dropdownvalue3,
                    icon: Icon(Icons.keyboard_arrow_down),
                    items: category.map((String category) {
                      return DropdownMenuItem(
                          value: category, child: Text(category));
                    }).toList(),
                    onChanged: (String? newValue3) {
                      setState(() {
                        dropdownvalue3 = newValue3!;
                      });
                    },
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                        textStyle: TextStyle(
                          fontSize: 18,
                        )),
                  ),
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
                        padding:
                            EdgeInsets.symmetric(horizontal: 27, vertical: 7),
                        textStyle: TextStyle(
                          fontSize: 18,
                        )),
                  ),
                  SizedBox(
                    height: 15,
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
                              builder: (context) => BookCurrentLocation(
                                category: dropdownvalue3,
                                email: email,
                                f_name: f_name,
                                language: dropdownvalue1,
                                num: dropdownvalue2,
                                s_name: s_name,
                                uid: uid,
                                phNumber: phNumber,
                                check: 0,
                              ),
                            ));
                      } else if (x == 2) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BookNextLocation(
                                category: dropdownvalue3,
                                email: email,
                                f_name: f_name,
                                language: dropdownvalue1,
                                num: dropdownvalue2,
                                s_name: s_name,
                                uid: uid,
                                phNumber: phNumber,
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
                            EdgeInsets.symmetric(horizontal: 53, vertical: 13),
                        textStyle: TextStyle(
                            fontSize: 25, fontWeight: FontWeight.bold)),
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
