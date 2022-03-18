import 'package:donor_app/donor_portion/admin_portion/organization_registration.dart';
import 'package:donor_app/login_screen.dart';
import 'package:donor_app/donor_portion/admin_portion/orgn_addlocation.dart';
import 'package:donor_app/organization_portion/social%20programs/checkprogram.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({Key? key}) : super(key: key);

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
        appBar: AppBar(title: Text("Admin home")),
        body: Center(
          child: Column(
            children: <Widget>[
              Text(
                "\n\n\n\n\n\n\n\nPlease Choose Option:\n",
                style: TextStyle(fontSize: 20),
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => OrganizationLocation(),
                        ));
                  },
                  child: Text("Register Organization")),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CheckProgram(),
                        ));
                  },
                  child: Text("Delete Program")),
              ElevatedButton(
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
                child: Text("LogOut"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
