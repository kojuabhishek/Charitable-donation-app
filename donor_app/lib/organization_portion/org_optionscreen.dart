import 'package:donor_app/organization_portion/confirmedDonation_list/confimedBook.dart';
import 'package:donor_app/organization_portion/detail_confirmation/confirmeddonation.dart';
import 'package:donor_app/organization_portion/org_screens/org_bookscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_clothescreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:donor_app/organization_portion/org_screens/org_foodscreen.dart';

import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:donor_app/organization_portion/social%20programs/social_program.dart';
import 'package:flutter/material.dart';

import 'org_screens/org_clothescreen.dart';

class OrganizationOptionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The System Back Button is Deactivated')));
        return false;
      },
      child: Scaffold(
          backgroundColor: Colors.yellowAccent[100],
          appBar: AppBar(
            title: Text("Welcome  Organization"),
          ),
          drawer: Org_Drawer(),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    "Click on the given option to check the details of donation or confirmed donation:\n\n",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                  SizedBox(
                    height: 400,
                    width: 400,
                    child: ListView.builder(
                        itemCount: 1,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) => Row(
                              children: <Widget>[
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              OrganizationHomeScreen(),
                                        ));
                                  },
                                  icon: Icon(Icons.list),
                                  label: Text(
                                    "Listed Donations",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 75, horizontal: 25),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          //ConfirmedDonations
                                          builder: (context) =>
                                              ConfirmedDonationScreen(),
                                        ));
                                  },
                                  icon: Icon(Icons.check_box),
                                  label: Text(
                                    "To be Picked Up",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.green,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 75, horizontal: 25),
                                  ),
                                ),
                                SizedBox(
                                  width: 20,
                                  height: 20,
                                ),
                                ElevatedButton.icon(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Program(),
                                        ));
                                  },
                                  icon: Icon(Icons.event),
                                  label: Text(
                                    "Add Programs",
                                    style: TextStyle(fontSize: 25),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    primary: Colors.purpleAccent[100],
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 75, horizontal: 25),
                                  ),
                                ),
                              ],
                            )),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
