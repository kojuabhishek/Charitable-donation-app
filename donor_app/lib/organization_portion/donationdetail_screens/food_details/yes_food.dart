import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/organization_portion/accept_donation/book_accept.dart';
import 'package:donor_app/organization_portion/accept_donation/food_accept.dart';
import 'package:donor_app/organization_portion/donationdetail_screens/food_details/foodgooglemapscreen.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'dart:math';

import 'package:url_launcher/url_launcher.dart';

List<double> distance = [];
var widgets_list = {'distance': [], 'data': []};

class YesFoods extends StatefulWidget {
  const YesFoods({Key? key}) : super(key: key);

  @override
  _YesFoodsState createState() => _YesFoodsState();
}

class _YesFoodsState extends State<YesFoods> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();
  double latitude = 0.0;
  double longitude = 0.0;
  final R = 6372.8;
  Future<void> getData() async {
    final inst = FirebaseFirestore.instance;

    QuerySnapshot snapshot = await inst.collection("Food Location").get();
    final allData = snapshot.docs.map((e) => e.data()).toList();
    //print(allData);
    sort(allData);
  }

  @override
  void initState() {
    super.initState();
    distance = [];
    widgets_list = {'distance': [], 'data': []};
    //final Stream<QuerySnapshot> snapshot =
    // FirebaseFirestore.instance.collection("Book Location").snapshots();
    FirebaseFirestore.instance
        .collection("organization")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInOrg = UserModel.fromMap(value.data());
      latitude = double.parse("${loggedInOrg.lat}");
      longitude = double.parse("${loggedInOrg.lon}");
      print("Logged in org info");
      print(latitude);
      print(longitude);
      getData();

      setState(() {});
    });
  }

  double haversine(double lat1, double lon1, e, int i) {
    double dLat = (double.parse(e[i]['latitude']) - lat1) * pi / 180;
    double dLon = (double.parse(e[i]['longitude']) - lon1) * pi / 180;
    lat1 = lat1 * pi / 180;
    double lon2 = double.parse(e[i]['longitude']) * pi / 180;
    double a =
        pow(sin(dLat / 2), 2) + pow(sin(dLon / 2), 2) * cos(lat1) * cos(lon2);

    double c = 2 * asin(sqrt(a.abs()));
    print(c);

    widgets_list['distance']?.add(R * c);
    widgets_list['data']?.add(e[i]);
    return R * c;
  }

  void sort(e) {
    for (int i = 0; i < e.length; i++) {
      haversine(latitude, longitude, e, i);
    }

    var temp = widgets_list['distance']![0];
    var temp_d = widgets_list['data']![0];

    for (var i = 0; i < widgets_list['distance']!.length; i++) {
      for (var j = 0; j < widgets_list['distance']!.length; j++) {
        if (widgets_list['distance']![j] > widgets_list['distance']![i]) {
          temp = widgets_list['distance']![i];
          widgets_list['distance']![i] = widgets_list['distance']![j];
          widgets_list['distance']![j] = temp;

          temp_d = widgets_list['data']![i];
          widgets_list['data']![i] = widgets_list['data']![j];
          widgets_list['data']![j] = temp_d;
        }
      }
    }
    for (var element in widgets_list['distance']!) {
      print(element);
    }
  }

  @override
  Widget build(BuildContext context) {
    int y = 0;
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Press Home Button to go back')));
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Details of Food Donation"),
        ),
        drawer: Org_Drawer(),
        body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: widgets_list['distance']!.length,
          itemBuilder: (BuildContext context, int index) {
            return Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                    child: Column(
                  children: [
                    Row(children: [
                      Text(
                        "Name : ",
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        widgets_list['data']![index]["first name"],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                      Text("\t"),
                      Text(
                        widgets_list['data']![index]["second name"],
                        style: TextStyle(
                          fontSize: 18,
                        ),
                      ),
                    ]),
                    Row(
                      children: [
                        Text(
                          "Type : ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widgets_list['data']![index]["type"],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "email : ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          widgets_list['data']![index]["email"],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        //SizedBox(width: 45,),
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          "Phone: ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        TextButton.icon(
                          onPressed: () {
                            String phn =
                                widgets_list['data']![index]["phNumber"];
                            String phone = "tel:$phn";
                            launch(phone);
                          },
                          icon: Icon(
                            Icons.phone,
                            color: Colors.greenAccent[700],
                          ),
                          label: Text(""),
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white24,
                          ),
                        ),
                        Text(
                          widgets_list['data']![index]["phNumber"],
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          "Distance: ",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          "${widgets_list['distance']![index]} km",
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    //SizedBox(width:30,),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodGoogleMapScreen(
                                  email: widgets_list['data']![index]["email"],
                                  f_name: widgets_list['data']![index]
                                      ["first name"],
                                  type: widgets_list['data']![index]["type"],
                                  s_name: widgets_list['data']![index]
                                      ["second name"],
                                  uid: widgets_list['data']![index]["uid"],
                                  phNumber: widgets_list['data']![index]
                                      ["phNumber"],
                                  lat: widgets_list['data']![index]["latitude"],
                                  lon: widgets_list['data']![index]
                                      ["longitude"],
                                  docID: widgets_list['data']![index]["docID"],
                                ),
                              ));
                        },
                        child: Text("View Location")),
                    SizedBox(
                      height: 2,
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => FoodsAccept(
                                  email: widgets_list['data']![index]["email"],
                                  f_name: widgets_list['data']![index]
                                      ["first name"],
                                  type: widgets_list['data']![index]["type"],
                                  s_name: widgets_list['data']![index]
                                      ["second name"],
                                  phNumber: widgets_list['data']![index]
                                      ["phNumber"],
                                  uid: widgets_list['data']![index]["uid"],
                                  lat: widgets_list['data']![index]["latitude"],
                                  lon: widgets_list['data']![index]
                                      ["longitude"],
                                  docID: widgets_list['data']![index]["docID"],
                                ),
                              ));
                        },
                        child: Text("Accept")),
                    Divider(
                      color: Colors.black.withOpacity(0.6),
                      thickness: 2,
                    ),
                  ],
                )));
          },
        ),
      ),
    );
  }
}
