// ignore_for_file: prefer_const_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/confirmation.dart';
import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/donor_portion/location/book_location/bookcurrent_location.dart';

import 'package:donor_app/donor_portion/location/book_location/booknext_location.dart';
import 'package:donor_app/donor_portion/location/clothes_location/clothescurrent_location.dart';
import 'package:donor_app/donor_portion/location/clothes_location/clothesnext_location.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/details_screen.dart';
import 'package:donor_app/donor_portion/screens/end_screen.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:donor_app/organization_portion/social%20programs/checkprogram.dart';
import 'package:donor_app/organization_portion/social%20programs/delete_program.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';

class Program extends StatefulWidget {
  const Program({Key? key}) : super(key: key);

  @override
  _ProgramState createState() => _ProgramState();
}

class _ProgramState extends State<Program> {
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

  final nameEditingController = new TextEditingController();
  final dateEditingController = new TextEditingController();
  final firstNameEditingController = new TextEditingController();
  int x = 0;
  int a = 0;
  int b = 0;

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("organization")
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

  late String name;
  late String date;

  @override
  Widget build(BuildContext context) {
    //password field
    final nameField = TextFormField(
        autofocus: false,
        controller: nameEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("field required");
          }
          if (!regex.hasMatch(value)) {
            return ("field required");
          }
          return null;
        },
        onSaved: (value) {
          nameEditingController.text = value!;
          //name = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.near_me),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Name and Details of Program",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    //date field
    final dateField = TextFormField(
        autofocus: false,
        controller: dateEditingController,
        keyboardType: TextInputType.name,
        validator: (value) {
          RegExp regex = new RegExp(r'^.{3,}$');
          if (value!.isEmpty) {
            return ("field required");
          }
          if (!regex.hasMatch(value)) {
            return ("field required");
          }
          return null;
        },
        onSaved: (value) {
          dateEditingController.text = value!;
          //date = value;
        },
        textInputAction: TextInputAction.next,
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.date_range),
          contentPadding: EdgeInsets.fromLTRB(20, 15, 20, 15),
          hintText: "Date of Program in YYYY-MM-DD",
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ));

    return Scaffold(
      //backgroundColor: Colors.lightBlue[100],
      appBar: AppBar(
        title: const Text("Social Program Screen"),
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
                    child: Image.asset("assets/volunteer.png",
                        fit: BoxFit.contain),
                  ),

                  SizedBox(height: 45),
                  nameField,
                  SizedBox(height: 20),
                  dateField,

                  //name = nameEditingController.text;

                  SizedBox(
                    height: 10,
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Text(
                    "Now Confirm the program:",
                    style: TextStyle(fontSize: 20),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        final ref = FirebaseFirestore.instance
                            .collection('Social Program')
                            .doc();

                        //write to database
                        Map<String, dynamic> data = {
                          "prgm name": nameEditingController.text,
                          "prgm date": dateEditingController.text,
                          "orgn first name": loggedInOrg.firstName,
                          "orgn second name": loggedInOrg.secondName,
                          "orgn email": loggedInOrg.email,
                          "orgn phNumber": loggedInOrg.phNumber,
                          "orgn uid": loggedInOrg.uid,
                          "docID": ref.id,
                        };
                        FirebaseFirestore.instance
                            .collection("Social Program")
                            .add(data);

                        Map<String, dynamic> data2 = {
                          "prgm name": nameEditingController.text,
                          "prgm date": dateEditingController.text,
                          "orgn first name": loggedInOrg.firstName,
                          "orgn second name": loggedInOrg.secondName,
                          "orgn email": loggedInOrg.email,
                          "orgn phNumber": loggedInOrg.phNumber,
                          "orgn uid": loggedInOrg.uid,
                          "docID": ref.id,
                        };

                        FirebaseFirestore.instance
                            .collection(
                                "volunteer_${loggedInOrg.firstName}_${loggedInOrg.secondName}_demand")
                            .add(data2);

                        Fluttertoast.showToast(msg: "Program Added");

                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => OrganizationOptionScreen()));
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
      drawer: Org_Drawer(),
    );
  }
}
