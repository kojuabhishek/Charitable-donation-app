import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';

import 'package:donor_app/organization_portion/donationdetail_screens/book_details/yes_books.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/food_details/yes_food.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_foodscreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class FoodsAccept extends StatefulWidget {
  String f_name, s_name, email, lat, lon, type, uid, docID, phNumber;

  FoodsAccept({
    Key? key,
    required this.f_name,
    required this.s_name,
    required this.email,
    required this.lat,
    required this.lon,
    required this.type,
    required this.uid,
    required this.phNumber,
    required this.docID,
  }) : super(key: key);

  @override
  _FoodsAcceptState createState() => _FoodsAcceptState();
}

class _FoodsAcceptState extends State<FoodsAccept> {
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

  sendMail() async {
    String username = 'cocharitable4@gmail.com';
    String password = '!123123qwe';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add(widget.email)
//      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Food Donation Accepted ${DateTime.now()}'
      ..text = 'This is to notify the book donation is accepted..\n'
      ..html =
          "<h1>Your donation of food is accepted by ${loggedInOrg.firstName} ${loggedInOrg.secondName}</h1>\n<h2>Keep on helping.we will contact you soon.\n Contact us:\n${loggedInOrg.email}\nPhone:${loggedInOrg.phNumber}</h2>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Fluttertoast.showToast(msg: "Email Sent");
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Confirmation"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
              child: Column(
            children: [
              Text(
                "\n\n\n\n\n\n\n\n\nPlease confirm that you will receiving the donation:",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () async {
                    sendMail();

                    //write data ro confirm book donation
                    Map<String, dynamic> data = {
                      "first name": widget.f_name,
                      "second name": widget.s_name,
                      "email": widget.email,
                      "uid": widget.uid,
                      "phNumber": widget.phNumber,
                      "type": widget.type,
                      "latitude": widget.lat,
                      "longitude": widget.lon,
                      "orgn first name": loggedInOrg.firstName,
                      "orgn second name": loggedInOrg.secondName,
                      "orgn email": loggedInOrg.email,
                      "orgn phNumber": loggedInOrg.phNumber,
                      "orgn uid": loggedInOrg.uid,
                      "docID": widget.docID,
                    };
                    FirebaseFirestore.instance
                        .collection("Confirmed Food")
                        .add(data);

                    FirebaseFirestore.instance
                        .collection(
                            "confirmed_${loggedInOrg.firstName}_${loggedInOrg.secondName}_food")
                        .add(data);

                    //Navigate to yes books
                    Fluttertoast.showToast(
                        msg: "written and moved to confirm food");

                    var collection =
                        FirebaseFirestore.instance.collection('Food Location');
                    var snapshot = await collection
                        .where('docID', isEqualTo: widget.docID)
                        .get();
                    for (var doc in snapshot.docs) {
                      await doc.reference.delete();
                    }

                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => Org_Foods()));
                  },
                  child: Text("Confirm")),
            ],
          )),
        ));
  }
}
