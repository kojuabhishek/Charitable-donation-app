import 'package:donor_app/donor_portion/confirmation.dart';
import 'package:donor_app/model/user_model.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/food_screen.dart';
import 'package:donor_app/donor_portion/screens/end_screen.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoding/geocoding.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:blinking_text/blinking_text.dart';

class FoodCurrentLocation extends StatefulWidget {
  late String? f_name, s_name, uid, email, type, phNumber;
  int check;

  FoodCurrentLocation({
    Key? key,
    required this.uid,
    required this.f_name,
    required this.s_name,
    required this.email,
    required this.type,
    required this.check,
    required this.phNumber,
  }) : super(key: key);

  @override
  _FoodCurrentLocationState createState() => _FoodCurrentLocationState();
}

class _FoodCurrentLocationState extends State<FoodCurrentLocation> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInOrg = UserModel();

  String location = 'Null, Press Button';
  String Address = 'search';
  int z = 0;

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

  late String? email = loggedInOrg.email;
  late String? f_name = loggedInOrg.firstName;
  late String? s_name = loggedInOrg.secondName;
  late String? uid = loggedInOrg.uid;
  late String? phNumber = loggedInOrg.phNumber;
  late String lat = '-1';
  late String lon = '-1';

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      await Geolocator.openLocationSettings();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);
  }

  Future<void> GetAddressFromLatLong(Position position) async {
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    print(placemarks);
    lat = ("${position.latitude}");
    lon = ("${position.longitude}");
    Placemark place = placemarks[0];
    Address =
        '${place.street}, ${place.subLocality}, ${place.locality}, ${place.postalCode}, ${place.country}';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: BlinkText(
                "Is your pickup address your current location?",
                style: TextStyle(
                    fontSize: 24.0,
                    //backgroundColor: Colors.yellow,
                    color: Colors.red),
                endColor: Colors.white,
                textScaleFactor: 1.25,
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () {
                  z = 12;
                },
                child: Text("Yes!")),
            SizedBox(
              height: 5,
            ),
            ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Foods(),
                      ));
                },
                child: Text("No!")),
            SizedBox(
              height: 20,
            ),
            Text(
              'Coordinates Points',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              location,
              style: TextStyle(color: Colors.black, fontSize: 16),
            ),
            SizedBox(
              height: 20,
            ),
            Text(
              'ADDRESS',
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text('${Address}'),
            ElevatedButton(
              onPressed: () async {
                if (z == 12) {
                  Position position = await _getGeoLocationPosition();
                  location =
                      'Lat: ${position.latitude} , Long: ${position.longitude}';
                  GetAddressFromLatLong(position);
                } else if (z == widget.check) {
                  Fluttertoast.showToast(msg: "Please press Yes or No");
                }
              },
              child: Text(
                'Get Location',
              ),
            ),
            SizedBox(
              height: 60,
            ),
            Text(
              "Confirm your Location",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () {
                final ref = FirebaseFirestore.instance
                    .collection('Food Location')
                    .doc();
                if (lat != '-1' && lon != '-1') {
                  //write to database
                  Map<String, dynamic> data = {
                    "first name": widget.f_name,
                    "second name": widget.s_name,
                    "email": widget.email,
                    "uid": widget.uid,
                    "phNumber": widget.phNumber,
                    "type": widget.type,
                    "latitude": lat,
                    "longitude": lon,
                    "docID": ref.id,
                  };
                  FirebaseFirestore.instance
                      .collection("Food Location")
                      .add(data);

                  //goto confrimation page

                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Confirmation(),
                      ));
                } else {
                  print("Error press get location");
                  Fluttertoast.showToast(
                      msg: "Please first press get location");
                }
              },
              child: Text("Confirm"),
              style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(horizontal: 53, vertical: 13),
                  textStyle:
                      TextStyle(fontSize: 25, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }
}
