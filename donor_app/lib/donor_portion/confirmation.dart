import 'package:donor_app/donor_portion/screens/end_screen.dart';
import 'package:donor_app/donor_portion/screens/home_screen.dart';
import 'package:flutter/material.dart';

import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/donor_portion/location/book_location/bookcurrent_location.dart';
import 'package:donor_app/donor_portion/location/book_location/booknext_location.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/food_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/volunteer_screen.dart';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';

class Confirmation extends StatelessWidget {
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
          //backgroundColor: Colors.purpleAccent,
          appBar: AppBar(
            title: const Text("Confirmation Screen"),
            // backgroundColor: Colors.orangeAccent,
            centerTitle: true,
          ),
          drawer: UserDrawer(),
          body: Form(
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("Do you want to donate other in categories?\n\n",
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 25,
                      )),
                  SizedBox(width: 75),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => HomeScreen(),
                          ));
                    },
                    icon: Icon(Icons.check_box),
                    label: Text("Yes"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        padding: MaterialStateProperty.all(EdgeInsets.all(30)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 30))),
                  ),
                  SizedBox(height: 75),
                  ElevatedButton.icon(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => End(),
                          ));
                    },
                    icon: Icon(Icons.blur_off),
                    label: Text("No"),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.indigo),
                        padding: MaterialStateProperty.all(EdgeInsets.all(20)),
                        textStyle:
                            MaterialStateProperty.all(TextStyle(fontSize: 20))),
                  ),
                ],
              ),
            ),
          )),
    );
  }
}
