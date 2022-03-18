import 'package:donor_app/donor_portion/screens/home_screen.dart';
import 'package:donor_app/donor_portion/screens/registration_screen.dart';
import 'package:donor_app/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ChangePassword extends StatefulWidget {
  ChangePassword({Key? key}) : super(key: key);

  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  final _formKey = GlobalKey<FormState>();
  var email = "";
  int x = 0;

  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  final emailController = TextEditingController();

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    emailController.dispose();
    super.dispose();
  }

  resetPassword() async {
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            backgroundColor: Colors.orangeAccent,
            content: Text(
              "Password Change Email has been sent !",
              style: TextStyle(fontSize: 18.0, color: Colors.black),
            )),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print("No user found for that email");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              backgroundColor: Colors.orangeAccent,
              content: Text(
                "No user found for that email",
                style: TextStyle(fontSize: 18.0, color: Colors.black),
              )),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('The System Back Button is Deactivated')));
        
        return false;
      },
      child: Scaffold(
        //backgroundColor: Colors.lightBlueAccent[100],
        appBar: AppBar(
          title: Text("Change Password"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 20.0),
                  child: Text(
                    'Please Enter your registered email address\n\nChange Password Link will be sent to your registered email id !',
                    style: TextStyle(fontSize: 20.0),
                  ),
                ),
                Expanded(
                  child: Form(
                    key: _formKey,
                    child: Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                      child: ListView(
                        children: [
                          Center(
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 10.0),
                              child: TextFormField(
                                autofocus: false,
                                decoration: InputDecoration(
                                  labelText: 'Email: ',
                                  labelStyle: TextStyle(fontSize: 20.0),
                                  border: OutlineInputBorder(),
                                  errorStyle: TextStyle(
                                      color: Colors.redAccent, fontSize: 15),
                                ),
                                controller: emailController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please Enter Email';
                                  } else if (!value.contains('@')) {
                                    return 'Please Enter Valid Email';
                                  }
                                  return null;
                                },
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      // Validate returns true if the form is valid, otherwise false.
                                      if (_formKey.currentState!.validate()) {
                                        setState(() {
                                          email = emailController.text;
                                        });
                                        resetPassword();
                                        x = x + 1;
                                      }
                                    },
                                    child: Text(
                                      'Send Email',
                                      style: TextStyle(fontSize: 18.0),
                                    ),
                                    style: ElevatedButton.styleFrom(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 12),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 30,
                                  ),
                                  // start of my code
                                  Container(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text("Proceed to Login:  ",
                                            style: TextStyle(fontSize: 18)),
                                        ElevatedButton(
                                          onPressed: () => {
                                            Navigator.pushAndRemoveUntil(
                                                context,
                                                PageRouteBuilder(
                                                  pageBuilder:
                                                      (context, a, b) =>
                                                          LoginScreen(),
                                                  transitionDuration:
                                                      Duration(seconds: 0),
                                                ),
                                                (route) => false)
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(fontSize: 15),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 5, vertical: 10),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  // end of my code
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 60,
                          ),
                          Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't want to change password? ",
                                  style: TextStyle(fontSize: 20),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  onPressed: () => {
                                    if (x == 0)
                                      {
                                        Navigator.pushAndRemoveUntil(
                                            context,
                                            PageRouteBuilder(
                                              pageBuilder: (context, a, b) =>
                                                  HomeScreen(),
                                              transitionDuration:
                                                  Duration(seconds: 0),
                                            ),
                                            (route) => false)
                                      }
                                    else if (x != 0)
                                      {
                                        Fluttertoast.showToast(
                                            msg:
                                                "Change password and login again"),
                                      }
                                  },
                                  child: Text(
                                    'Goto Home',
                                    style: TextStyle(
                                      fontSize: 18,
                                    ),
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 15),
                                  ),
                                ),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
