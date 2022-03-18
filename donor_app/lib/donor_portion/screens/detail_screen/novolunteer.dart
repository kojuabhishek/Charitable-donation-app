import 'package:donor_app/donor_portion/screens/home_screen.dart';
import 'package:donor_app/organization_portion/org_optionscreen.dart';
import 'package:donor_app/organization_portion/organization_homescreen.dart';
import 'package:flutter/material.dart';

class NoVolunteer extends StatelessWidget {
  const NoVolunteer({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("No Confirmed Programs"),
        
      ),
     
      body: Center(
        child: Column(
          children: [
            Text("No Social Program recorded"),
            SizedBox(height:25,),
            ElevatedButton(onPressed: (){
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => HomeScreen()));
            },
             child: Text("Goto Home"))
          ],
        )
        
        
      
      ),
     
      
     
      
    );
  }
}