import 'package:donor_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class UserVerification extends StatefulWidget {
  const UserVerification({Key? key}) : super(key: key);

  @override
  _UserVerificationState createState() => _UserVerificationState();
}

class _UserVerificationState extends State<UserVerification> {
  User? user = FirebaseAuth.instance.currentUser;

  verifyEmail() async {
    if (user != null && !user!.emailVerified) {
      await user!.sendEmailVerification();
      print('Verification Email has been sent');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          backgroundColor: Colors.orangeAccent,
          content: Text(
            'Verification Email has been sent',
            style: TextStyle(fontSize: 18.0, color: Colors.black),
          ),
        ),
      );
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => LoginScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'The System Back Button is Deactivated for this screen.')));
        return false;
      },
      child: Scaffold(
          appBar: AppBar(
            title: Text("Verification"),
          ),
          body: Container(
              margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
              child: Column(children: [
                Column(
                  children: [
                    Text(
                      'To Login You Must Have to Verify your Email !!\n\n Please verify email\n ',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    ElevatedButton(
                        onPressed: () => {verifyEmail()},
                        child: Text(
                          'Verify Email',
                          style: TextStyle(fontSize: 20),
                        ))
                  ],
                ),
                SizedBox(
                  height: 100,
                ),
                Text(
                  "Don't Want to verify email?",
                  style: TextStyle(fontSize: 15),
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                    },
                    icon: Icon(Icons.logout),
                    label: Text("Logout"))
              ]))),
    );
  }
}
