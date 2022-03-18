import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/accept_donation/book_accept.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/googlemapscreen.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class YesHistory extends StatefulWidget {
  const YesHistory({Key? key}) : super(key: key);

  @override
  _YesHistoryState createState() => _YesHistoryState();
}

class _YesHistoryState extends State<YesHistory> {
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

  @override
  Widget build(BuildContext context) {
    int y = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("History"),
      ),
      drawer: Org_Drawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "completed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_history")
            .snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasData) {
            return Padding(
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
                                e["first name"],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                              Text("\t"),
                              Text(
                                e["second name"],
                                style: TextStyle(
                                  fontSize: 18,
                                ),
                              ),
                            ]),
                            
                            Row(
                              children: [
                                Text(
                                  "Contribution category : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["C_Type"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "email : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["email"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Phone : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["phNumber"],
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
            );
          }
          return CircularProgressIndicator();
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (context) => OrganizationOptionScreen()));
        },
        child: const Icon(Icons.home),
      ),
    );
  }
}
