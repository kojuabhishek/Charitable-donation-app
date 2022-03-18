import 'dart:convert';

import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClothesGoogleMapScreen extends StatefulWidget {
  String f_name, s_name, email, gender, lat, lon, age, uid, docID, phNumber;
  ClothesGoogleMapScreen({
    Key? key,
    required this.f_name,
    required this.s_name,
    required this.email,
    required this.gender,
    required this.lat,
    required this.lon,
    required this.age,
    required this.uid,
    required this.phNumber,
    required this.docID,
  }) : super(key: key);
  @override
  _ClothesGoogleMapScreenState createState() => _ClothesGoogleMapScreenState();
}

class _ClothesGoogleMapScreenState extends State<ClothesGoogleMapScreen> {
  List<Marker> myMarker = [];
  String latitude = '', longitude = '';
  double la = 0.0, ln = 0.0;

  @override
  void initState() {
    super.initState();
    latitude = widget.lat;
    longitude = widget.lon;
    la = double.parse(latitude);
    ln = double.parse(longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Map"),
      ),
      drawer: Org_Drawer(),
      body: GoogleMap(
        myLocationEnabled: true,
        onMapCreated: _handleTap(),
        initialCameraPosition: CameraPosition(
          target: LatLng(la, ln),
          zoom: 15,
        ),
        markers: Set.from(myMarker),
      ),
    );
  }

  _handleTap() {
    LatLng Location = LatLng(la, ln);
    setState(() {
      myMarker = [];
      myMarker.add(
        Marker(
          markerId: MarkerId(Location.toString()),
          position: Location,
        ),
      );
    });
  }
}
