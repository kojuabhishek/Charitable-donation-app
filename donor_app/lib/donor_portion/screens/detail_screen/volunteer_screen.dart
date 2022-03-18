import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/novolunteer.dart';

import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/accept_donation/book_accept.dart';
import 'package:donor_app/organization_portion/accept_donation/food_accept.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

var now = new DateTime.now();
var formatter = new DateFormat('yyyy-MM-dd');
String formattedDate = formatter.format(now);

class Volunteer extends StatefulWidget {
  const Volunteer({Key? key}) : super(key: key);

  @override
  _VolunteerState createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  final _formKey = GlobalKey<FormState>();

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

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

  @override
  Widget build(BuildContext context) {
    int x = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of Social Program"),
      ),
      drawer: UserDrawer(),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Social Program").snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Container(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView(
                  children: snapshot.data!.docs
                      .map((e) => SingleChildScrollView(
                              child: Column(
                            children: [
                              Row(children: [
                                Text(
                                  "Name : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["orgn first name"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text("\t"),
                                Text(
                                  e["orgn second name"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ]),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Email : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Text(
                                    e["orgn email"],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  SizedBox(
                                    width: 60,
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Program name : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Flexible(
                                    child: Text(
                                      e["prgm name"],
                                      style: TextStyle(
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Program date : ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  Builder(builder: (context) {
                                    /// some operation here ...
                                    if (formattedDate
                                            .compareTo(e["prgm date"]) <
                                        0) {
                                      // print(formattedDate);
                                      // print("current date: $formattedDate");
                                      // print("program date");
                                      // print(e["prgm date"]);
                                      // print("This program should be delete");
                                      // print("printed once");
                                      return Text(
                                        "Expired",
                                        style: TextStyle(
                                          fontSize: 18,
                                          backgroundColor: Colors.red,
                                        ),
                                      );
                                    } else {
                                      return Text(
                                        e["prgm date"],
                                        style: TextStyle(
                                          fontSize: 18,
                                        ),
                                      );
                                    }
                                    return Text('');
                                  }),
                                ],
                              ),
                              Row(
                                children: [
                                  Text(
                                    "Phone Number: ",
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextButton.icon(
                                    onPressed: () {
                                      String phn = e["orgn phNumber"];
                                      String phone = "tel:$phn";
                                      launch(phone);
                                    },
                                    icon: Icon(
                                      Icons.phone,
                                      color: Colors.greenAccent[700],
                                    ),
                                    label: Text(""),
                                    style: ElevatedButton.styleFrom(
                                        primary: Colors.white24,
                                        padding: EdgeInsets.all(0)),
                                  ),
                                  Text(
                                    e["orgn phNumber"],
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                ],
                              ),
                              Divider(
                                color: Colors.black.withOpacity(0.6),
                                thickness: 2,
                              ),
                            ],
                          )))
                      .toList(),
                ),
              ),
            );
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
