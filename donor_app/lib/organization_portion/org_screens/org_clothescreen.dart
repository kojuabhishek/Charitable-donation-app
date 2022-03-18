import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/no_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/clothes_details/no_clothes.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/clothes_details/yes_clothes.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Org_Clothes extends StatefulWidget {
  const Org_Clothes({Key? key}) : super(key: key);

  @override
  _Org_ClothesState createState() => _Org_ClothesState();
}

class _Org_ClothesState extends State<Org_Clothes> {
  int check = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Clothes Location")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading....");
            }
            if (snapshot.data!.docs.isEmpty) {
              print("No data");
              return NoClothes();
            }
            return YesClothes();
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
