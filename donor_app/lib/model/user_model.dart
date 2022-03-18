import 'package:flutter/material.dart';

class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? phNumber;
  String? role;
  String? lat;
  String? lon;

  UserModel(
      {this.uid,
      this.email,
      this.firstName,
      this.secondName,
      this.phNumber,
      this.role,
      this.lat,
      this.lon});

  // receiving data from server
  factory UserModel.fromMap(map) {
    return UserModel(
      uid: map['uid'],
      email: map['email'],
      firstName: map['firstName'],
      secondName: map['secondName'],
      phNumber: map['phNumber'],
      role: map['role'],
      lat: map['lat'],
      lon: map['lon'],
    );
  }

  // sending data to our server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'phNumber': phNumber,
      'role': role,
      'lat': lat,
      "lon": lon,
    };
  }
}
