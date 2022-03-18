import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/no_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/food_details/no_food.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/food_details/yes_food.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Org_Foods extends StatefulWidget {
  const Org_Foods({Key? key}) : super(key: key);

  @override
  _Org_FoodsState createState() => _Org_FoodsState();
}

class _Org_FoodsState extends State<Org_Foods> {
  int check = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Food Location")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading....");
            }
            if (snapshot.data!.docs.isEmpty) {
              print("No data");
              return NoFoods();
            }
            return YesFoods();
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
