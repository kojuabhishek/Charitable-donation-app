import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/admin_portion/admin_home.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:donor_app/organization_portion/social%20programs/social_program.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DeleteProgram extends StatefulWidget {
  const DeleteProgram({Key? key}) : super(key: key);

  @override
  _DeleteProgramState createState() => _DeleteProgramState();
}

class _DeleteProgramState extends State<DeleteProgram> {
  @override
  Widget build(BuildContext context) {
    int y = 0;
    return Scaffold(
      appBar: AppBar(
        title: Text("Details of Program"),
      ),
      // drawer: Org_Drawer(),
      body: StreamBuilder(
        stream:
            FirebaseFirestore.instance.collection("Social Program").snapshots(),
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
                                "Program Name : ",
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
                              Text("\t"),
                            ]),
                            Row(
                              children: [
                                Text(
                                  "Date : ",
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                Text(
                                  e["prgm date"],
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                ),
                                SizedBox(
                                  width: 173,
                                ),
                              ],
                            ),
                            ElevatedButton(
                                onPressed: () async {
                                  var collection = FirebaseFirestore.instance
                                      .collection("Social Program");

                                  var snapshot = await collection
                                      .where('docID', isEqualTo: e["docID"])
                                      .get();
                                  for (var doc in snapshot.docs) {
                                    doc.reference.delete();
                                  }
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DeleteProgram()));
                                },
                                child: Text("Delete")),
                            /* ElevatedButton(
                                onPressed: () async {
                                  if (x == 1) {
                                    var collection = FirebaseFirestore.instance
                                        .collection(
                                            "volunteer_${loggedInOrg.firstName}_${loggedInOrg.secondName}_demand");
                                    var snapshot = await collection
                                        .where('docID', isEqualTo: e["docID"])
                                        .get();
                                    for (var doc in snapshot.docs) {
                                      await doc.reference.delete();
                                    }

                                    Navigator.of(context).pushReplacement(
                                        MaterialPageRoute(
                                            builder: (context) => Program()));
                                  }
                                  else{
                                    Fluttertoast.showToast(msg: "Please Press Delete First ");

                                  }
                                },
                                child: Text("Confirm")),*/
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
    );
  }
}
