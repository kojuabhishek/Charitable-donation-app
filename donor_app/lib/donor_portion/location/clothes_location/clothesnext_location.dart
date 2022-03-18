import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:donor_app/donor_portion/confirmation.dart';
import 'package:donor_app/donor_portion/drawer.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClothesNextLocation extends StatefulWidget {
  late String? f_name, s_name, uid, email, gender, age, phNumber;
  int check;

  ClothesNextLocation({
    Key? key,
    required this.age,
    required this.uid,
    required this.f_name,
    required this.s_name,
    required this.email,
    required this.gender,
    required this.check,
    required this.phNumber,
  }) : super(key: key);

  @override
  _ClothesNextLocationState createState() => _ClothesNextLocationState();
}

class _ClothesNextLocationState extends State<ClothesNextLocation> {
  var lat, lng;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

  String location = 'Null, Press Button';
  String Address = 'search';
  int z = 0;
  int x = 0;

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

  List<Marker> myMarker = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Google Map"),
      ),
      drawer: UserDrawer(),
      body: Stack(children: [
        GoogleMap(
          myLocationEnabled: true,
          onTap: _handleTap,
          initialCameraPosition: CameraPosition(
            target: LatLng(27.7172, 85.3240),
            zoom: 15,
          ),
          markers: Set.from(myMarker),
        ),
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.only(top: 10, bottom: 10),
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(100),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 10,
                      offset: Offset.zero)
                ]),
            width: 40,
            height: 40,
            child: Text(
              "Tap! to select your location",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.cyan,
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment(-0.5, 0.935),
          child: SizedBox(
            height: 40,
            width: 200,
            child: ElevatedButton(
              onPressed: () {
                if (x == 1) {
                  final ref = FirebaseFirestore.instance
                      .collection('Clothes Location')
                      .doc();
                  //write to database
                  Map<String, dynamic> data = {
                    "first name": widget.f_name,
                    "second name": widget.s_name,
                    "email": widget.email,
                    "uid": widget.uid,
                    "phNumber": widget.phNumber,
                    "gender": widget.gender,
                    "age": widget.age,
                    "latitude": lat,
                    "longitude": lng,
                    "docID": ref.id,
                  };
                  FirebaseFirestore.instance
                      .collection("Clothes Location")
                      .add(data);

                  //goto confrimation page

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Confirmation(),
                      ));
                } else {
                  Fluttertoast.showToast(
                      msg: "Please select a Location to continue");
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Color(0xff4267B2),
              ),
              child: const Text('Confirm',
                  style: TextStyle(color: Colors.white, fontSize: 20)),
            ),
          ),
        )
      ]),
    );
  }

  _handleTap(LatLng tappedPoint) {
    print(tappedPoint);
    lat = tappedPoint.latitude.toString();
    lng = tappedPoint.longitude.toString();
    setState(() {
      x = 1;
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(tappedPoint.toString()),
          position: tappedPoint,
        ),
      );
    });
  }
}
