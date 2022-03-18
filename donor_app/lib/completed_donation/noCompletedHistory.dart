import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:flutter/material.dart';

class NoHistory extends StatelessWidget {
  const NoHistory({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Press Home Button to go back')));
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: Text("No Completed Donations"),
          ),
          body: Center(
              child: Column(
            children: [
              SizedBox(
                height: 200,
              ),
              Text("No Completed Donation"),
              SizedBox(
                height: 25,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => OrganizationOptionScreen()));
                  },
                  child: Text("Goto Home"))
            ],
          )),
        ));
  }
}
