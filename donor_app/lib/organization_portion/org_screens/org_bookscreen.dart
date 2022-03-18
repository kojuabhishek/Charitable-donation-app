import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/no_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Org_Books extends StatefulWidget {
  const Org_Books({Key? key}) : super(key: key);

  @override
  _Org_BooksState createState() => _Org_BooksState();
}

class _Org_BooksState extends State<Org_Books> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

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

  int check = 0;

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Book Location")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading....");
            }
            if (snapshot.data!.docs.isEmpty) {
              print("No data");
              return NoBooks();
            }
            return YesBooks();
          }),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => OrganizationOptionScreen(),
                ));
          }),
    );
  }
}
