import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/change_password.dart';
import 'package:donor_app/completed_donation/completedHistory.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/donor_portion/screens/home_screen.dart';
import 'package:donor_app/login_screen.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/donor_portion/admin_portion/orgn_addlocation.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Org_Drawer extends StatefulWidget {
  const Org_Drawer({Key? key}) : super(key: key);

  @override
  _Org_DrawerState createState() => _Org_DrawerState();
}

class _Org_DrawerState extends State<Org_Drawer> {
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
    return Drawer(
      // Add a ListView to the drawer. This ensures the user can scroll
      // through the options in the drawer if there isn't enough vertical
      // space to fit everything.
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountEmail:
                Text("${loggedInOrg.firstName} ${loggedInOrg.secondName}",
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w500,
                      fontSize: 30,
                    )),
            accountName: Text("${loggedInOrg.email}",
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w500,
                )),
            /*currentAccountPicture: CircleAvatar(
              child: Text("USER"),
            ),*/
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("Home"),
            onTap: () {
              print("Home Clicked");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => OrganizationOptionScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(CupertinoIcons.lock),
            title: Text("Change Password"),
            onTap: () async => {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChangePassword(),
                  ),
                  (route) => false)
            },
          ),
          ListTile(
            leading: Icon(Icons.history),
            title: Text("History"),
            onTap: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => History(),
                  ),
                  (route) => false);
            },
          ),
          ListTile(
            leading: Icon(Icons.logout),
            title: Text("Logout"),
            onTap: () async => {
              await FirebaseAuth.instance.signOut(),
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                  (route) => false)
            },
          ),
        ],
      ),
    );
  }
}
