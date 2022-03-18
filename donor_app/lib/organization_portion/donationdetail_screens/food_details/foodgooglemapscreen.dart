import 'dart:convert';

import 'package:donor_app/organization_portion/org_screens/org_drawer.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class FoodGoogleMapScreen extends StatefulWidget {
  String f_name, s_name, email, type, lat, lon, uid, docID, phNumber;
  FoodGoogleMapScreen({
    Key? key,
    required this.f_name,
    required this.s_name,
    required this.email,
    required this.lat,
    required this.lon,
    required this.type,
    required this.uid,
    required this.phNumber,
    required this.docID,
  }) : super(key: key);
  @override
  _FoodGoogleMapScreenState createState() => _FoodGoogleMapScreenState();
}

class _FoodGoogleMapScreenState extends State<FoodGoogleMapScreen> {
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
