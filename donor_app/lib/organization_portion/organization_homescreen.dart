import 'package:donor_app/organization_portion/org_screens/org_bookscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_clothescreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:donor_app/organization_portion/org_screens/org_foodscreen.dart';

import 'package:flutter/material.dart';

import 'org_screens/org_clothescreen.dart';

class OrganizationHomeScreen extends StatefulWidget {
  const OrganizationHomeScreen({Key? key}) : super(key: key);

  @override
  _OrganizationHomeScreenState createState() => _OrganizationHomeScreenState();
}

class _OrganizationHomeScreenState extends State<OrganizationHomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.indigo[100],
        appBar: AppBar(
          title: Text("Donation Details"),
        ),
        drawer: Org_Drawer(),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "Click on the given option to check the details of donation:\n\n",
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
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Org_Books(),
                                      ));
                                },
                                child: Image.asset(
                                  "assets/books_button.png",
                                  height: 100,
                                  width: 250,
                                  fit: BoxFit.fill,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  primary: Colors.white,
                                  shadowColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Org_Clothes(),
                                      ));
                                },
                                child: Image.asset(
                                  "assets/clothes_button.jpg",
                                  height: 100,
                                  width: 250,
                                  fit: BoxFit.fill,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  primary: Colors.white,
                                  shadowColor: Colors.black,
                                ),
                              ),
                              SizedBox(
                                width: 70,
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Org_Foods(),
                                      ));
                                },
                                child: Image.asset(
                                  "assets/food_button.jpg",
                                  height: 100,
                                  width: 250,
                                  fit: BoxFit.fill,
                                ),
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.all(0),
                                  primary: Colors.white,
                                  shadowColor: Colors.black,
                                ),
                              ),
                            ],
                          )),
                ),
              ],
            ),
          ),
        ));
  }
}
