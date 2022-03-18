import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/accept_donation/book_accept.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/book_details/googlemapscreen.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YesConfirmedBooks extends StatefulWidget {
  const YesConfirmedBooks({Key? key}) : super(key: key);

  @override
  _YesConfirmedBooksState createState() => _YesConfirmedBooksState();
}

class _YesConfirmedBooksState extends State<YesConfirmedBooks> {
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
        title: Text("Details of Book Donation"),
      ),
      drawer: Org_Drawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_book")
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
                                  "Number : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["num"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 173,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Category : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["category"],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Language : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["language"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                              ],
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
                                TextButton.icon(
                                    onPressed: () {
                                      String phn = e["phNumber"];
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
                            ElevatedButton(
                                onPressed: () async {
                                  //write to database
                                   Map<String, dynamic> data = {
                    "C_Type":"Book",
                    "first name": e["first name"],
                    "second name": e["second name"],
                    "email": e["email"],
                    "uid": e["uid"],
                    "num": e["num"],
                    "language": e["language"],
                    "category":  e["category"],
                    "phNumber": e["phNumber"],
                    "latitude": e["latitude"],
                    "longitude": e["longitude"],
                     
                  };
                  FirebaseFirestore.instance
                      .collection("completed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_history")
                      .add(data);

                                  
                                  //deletion
                                  var collection = FirebaseFirestore.instance
                                      .collection(
                                          "confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_book");
                                  var snapshot = await collection
                                      .where('docID', isEqualTo: e["docID"])
                                      .get();
                                  for (var doc in snapshot.docs) {
                                    await doc.reference.delete();
                                  }
                                },
                                child: Text("Received")),
                            ElevatedButton(
                                onPressed: () {
                                  


                                  //mapscreen
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GoogleMapScreen(
                                          category: e["category"],
                                          email: e["email"],
                                          f_name: e["first name"],
                                          language: e["language"],
                                          numb: e["num"],
                                          s_name: e["second name"],
                                          uid: e["uid"],
                                          phNumber: e["phNumber"],
                                          lat: e["latitude"],
                                          lon: e["longitude"],
                                          docID: e["docID"],
                                        ),
                                      ));
                                },
                                child: Text("View Location")),
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
