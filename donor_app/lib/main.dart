import 'package:donor_app/change_password.dart';
import 'package:donor_app/donor_portion/location/book_location/bookcurrent_location.dart';

import 'package:donor_app/donor_portion/screens/detail_screen/books_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/clothes_screen.dart';
import 'package:donor_app/donor_portion/screens/detail_screen/food_screen.dart';
import 'package:donor_app/donor_portion/screens/end_screen.dart';
import 'package:donor_app/email_verify.dart';
import 'package:donor_app/login_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Charitable',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}
