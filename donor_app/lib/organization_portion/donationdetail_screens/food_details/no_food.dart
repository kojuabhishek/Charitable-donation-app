import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:flutter/material.dart';

class NoFoods extends StatelessWidget {
  const NoFoods({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(
                'Press Go to Home button to go back')));
        return false;
      },
      child:Scaffold(
      appBar: AppBar(
        title: Text("No Foods"),
      ),
      body: Center(
          child: Column(
        children: [
          SizedBox(
            height: 200,
          ),
          Text("No Available Food Donations"),
          SizedBox(
            height: 25,
          ),
          ElevatedButton(
              onPressed: () {
                // Navigator.of(context).pushReplacement(MaterialPageRoute(
                //     builder: (context) => OrganizationOptionScreen()));
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OrganizationOptionScreen(),
                    ),
                    (Route<dynamic> route) => false,
                  );
              },
              child: Text("Goto Home"))
        ],
      )),
    ));
  }
}
