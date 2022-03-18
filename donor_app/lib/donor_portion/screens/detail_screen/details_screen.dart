// ignore_for_file: prefer_const_constructors

import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/food_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/volunteer_screen.dart';
import 'package:flutter/material.dart';

class Details extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // ScaffoldMessenger.of(context).showSnackBar(
        //     SnackBar(content: Text('The System Back Button is Deactivated')));
        return true;
      },
      child: Scaffold(
        backgroundColor: Colors.indigo[100],
        body: Center(
          child: SingleChildScrollView(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  "How Would You like to contribute?\nPlease choose option :\n\n",
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
                                        builder: (context) => Books(),
                                      ));
                                },

                                //icon: Icon(Icons.auto_stories_rounded),
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
                                        builder: (context) => Clothes(),
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
                                        builder: (context) => Foods(),
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
                              SizedBox(
                                width: 70,
                                height: 20,
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Volunteer(),
                                      ));
                                },
                                child: Image.asset(
                                  "assets/volunteer_button.jpg",
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

                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Books(),
                  //         ));
                  //   },

                  //   //icon: Icon(Icons.auto_stories_rounded),
                  //   child: Image.asset(
                  //     "assets/books_button.png",
                  //     height: 100,
                  //     width: 250,
                  //     fit: BoxFit.fill,
                  //   ),

                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.all(0),
                  //     primary: Colors.white,
                  //     shadowColor: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 70,
                  //   height: 20,
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Clothes(),
                  //         ));
                  //   },
                  //   child: Image.asset(
                  //     "assets/clothes_button.jpg",
                  //     height: 100,
                  //     width: 250,
                  //     fit: BoxFit.fill,
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.all(0),
                  //     primary: Colors.white,
                  //     shadowColor: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 70,
                  //   height: 20,
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Foods(),
                  //         ));
                  //   },
                  //   child: Image.asset(
                  //     "assets/food_button.jpg",
                  //     height: 100,
                  //     width: 250,
                  //     fit: BoxFit.fill,
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.all(0),
                  //     primary: Colors.white,
                  //     shadowColor: Colors.black,
                  //   ),
                  // ),
                  // SizedBox(
                  //   width: 70,
                  //   height: 20,
                  // ),
                  // ElevatedButton(
                  //   onPressed: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //           builder: (context) => Volunteer(),
                  //         ));
                  //   },
                  //   child: Image.asset(
                  //     "assets/volunteer_button.jpg",
                  //     height: 100,
                  //     width: 250,
                  //     fit: BoxFit.fill,
                  //   ),
                  //   style: ElevatedButton.styleFrom(
                  //     padding: EdgeInsets.all(0),
                  //     primary: Colors.white,
                  //     shadowColor: Colors.black,
                  //   ),
                  // ),
                )
              ],
            ),
          )),
        ),
      ),
    );
  }
}
