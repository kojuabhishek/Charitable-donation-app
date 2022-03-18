import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/novolunteer.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/volunteer_screen.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/no_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/clothes_details/no_clothes.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/clothes_details/yes_clothes.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:fluttertoast/fluttertoast.dart';

class VolunteerCheck extends StatefulWidget {
  const VolunteerCheck({Key? key}) : super(key: key);

  @override
  _VolunteerCheckState createState() => _VolunteerCheckState();
}

class _VolunteerCheckState extends State<VolunteerCheck> {
  int check = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("Social Program")
              .snapshots(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Text("Loading....");
            }
            if (snapshot.data!.docs.isEmpty) {
              print("No data");
              return NoVolunteer();
            }
            return Volunteer();
          }),
     
    );
  }
}
