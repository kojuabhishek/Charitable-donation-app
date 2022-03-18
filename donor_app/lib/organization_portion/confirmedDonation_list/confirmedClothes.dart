import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/detail_confirmation/clothes/noConfirmedClothes.dart';
import 'package:donor_app/organization_portion/detail_confirmation/clothes/yesConfirmedClothes.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/no_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/clothes_details/yes_clothes.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ConfirmedClothes extends StatefulWidget {
  const ConfirmedClothes({Key? key}) : super(key: key);

  @override
  _ConfirmedClothesState createState() => _ConfirmedClothesState();
}

class _ConfirmedClothesState extends State<ConfirmedClothes> {
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
    return  Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_clothes")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading....");
            }
            if (snapshot.data!.docs.isEmpty) {
              print("No data");
              return NoConfirmedClothes();
            }
            return YesConfirmedClothes();
          }),
           

    );
  }
}
