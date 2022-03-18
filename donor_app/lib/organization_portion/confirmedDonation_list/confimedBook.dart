import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/detail_confirmation/book/noConfirmedBooks.dart';
import 'package:donor_app/organization_portion/detail_confirmation/book/yesConfirmedBooks.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/no_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmedBooks extends StatefulWidget {
  const ConfirmedBooks({Key? key}) : super(key: key);

  @override
  _ConfirmedBooksState createState() => _ConfirmedBooksState();
}

class _ConfirmedBooksState extends State<ConfirmedBooks> {
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
                  .collection(
                      "confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_book")
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Text("Loading....");
                }
                if (snapshot.data!.docs.isEmpty) {
                  print("No data");
                  return NoConfirmedBooks();
                }
                return YesConfirmedBooks();
              }),
        );
  }
}
