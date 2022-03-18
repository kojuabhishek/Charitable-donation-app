import 'package:donor_app/donor_portion/screens/detail_screen/details_screen.dart';
import 'package:donor_app/donor_portion/screens/home_screen.dart';
import 'package:donor_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

var quotes = [
  "Giving is not just about Donation, its about making a change.",
  "Be the change you want to see in the world.",
  "The results of philathropy is beyond Calculation.",
  "No act of Kindness, no matter how small is ever wasted."
];

var rng = new Random();

class End extends StatelessWidget {
  const End({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content:
                Text('The System Back Button is Deactivated in this screen')));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text("End Screen"),
          centerTitle: true,
        ),
        //backgroundColor: Colors.lightBlueAccent,
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  quotes[rng.nextInt(4)] + "\n\nThank you for Donating!!!",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 100,
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => HomeScreen(),
                        ));
                  },
                  child: Text(
                    "Go to home",
                    style: TextStyle(fontSize: 20),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 26, vertical: 21),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  icon: Icon(Icons.logout),
                  label: Text("Logout"),
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.indigo),
                      padding: MaterialStateProperty.all(EdgeInsets.all(13)),
                      textStyle:
                          MaterialStateProperty.all(TextStyle(fontSize: 20))),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
