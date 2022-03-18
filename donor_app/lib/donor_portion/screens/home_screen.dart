import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/details_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
    return WillPopScope(
      onWillPop: () async {
        //final shouldPop = await showWaring(context);
        //return shouldPop ?? false;
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Donation Screen"),
          centerTitle: true,
        ),
        drawer: UserDrawer(),
        /*body: Container(
          padding: EdgeInsets.all(10),
          child: Text(
            "How would you like to contribute?",
            style: TextStyle(
                fontSize: 24,
                color: Colors.blueAccent, //font color
                decoration: TextDecoration.underline, //make underline
                decorationThickness: 1.5, //decoration 'underline' thickness
                fontStyle: FontStyle.italic),
          ),
        ),*/
        body: Details(),
      ),
    );
  }

  // the logout function
  Future<void> logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (context) => LoginScreen()));
  }
}

Future<bool?> showWaring(BuildContext context) async => showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
          title: Text(
            "Do you want to exit the application?",
            style: TextStyle(
              color: Colors.indigo,
              //Color(0xff4267B2),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text("No"),
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
            ),
            TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text("Yes")),
          ],
        ));
