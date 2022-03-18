import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/accept_donation/book_accept.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/clothes_details/clothesgooglemapscree.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class YesConfirmedClothes extends StatefulWidget {
  const YesConfirmedClothes({Key? key}) : super(key: key);

  @override
  _YesConfirmedClothesState createState() => _YesConfirmedClothesState();
}

class _YesConfirmedClothesState extends State<YesConfirmedClothes> {
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
        title: Text("Details of Clothes Donation"),
      ),
      drawer: Org_Drawer(),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection(
                "confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_clothes")
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
                                  "Gender : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["gender"],
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                Text(
                                  "Age : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["age"],
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
                                  "Phone: ",
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
                    "C_Type":"Clothes",
                    "first name": e["first name"],
                    "second name": e["second name"],
                    "email": e["email"],
                    "uid": e["uid"],
                    
                    
                   
                    "phNumber": e["phNumber"],
                    "latitude": e["latitude"],
                    "longitude": e["longitude"],
                     
                  };
                  FirebaseFirestore.instance
                      .collection("completed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_history")
                      .add(data);

                                  var collection = FirebaseFirestore.instance
                                      .collection(
                                          "confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_clothes");
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
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            ClothesGoogleMapScreen(
                                          gender: e["gender"],
                                          email: e["email"],
                                          f_name: e["first name"],
                                          age: e["age"],
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
