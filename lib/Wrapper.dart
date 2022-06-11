import 'dart:math';

import 'package:doctorappointment/Screens/Authenticate/Authenticate.dart';
import 'package:doctorappointment/Screens/DoctorDashboard.dart';
import 'package:doctorappointment/Screens/DoctorList.dart';
import 'package:doctorappointment/Screens/FinishPage.dart';
import 'package:doctorappointment/models/user.dart';
import 'package:doctorappointment/shared/constants.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:doctorappointment/Screens/DoctorCategory.dart';
import 'package:doctorappointment/Services/auth.dart';

class Wrapper extends StatelessWidget {
  final AuthService _auth = AuthService();
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
//    print(user.uid);

    if (user == null) {
      return Authenticate();
    } else {
//      print(_auth.getSpecie(user.uid).toString());
//      _auth.getSpecie(user.uid).then((value) {
//        if (value == "Doctor") {
//          return DoctorCategory();
//        } else
//          return FinishPage();
//      });
      return UserTypeFinder(user);
    }
  }
}

class UserTypeFinder extends StatefulWidget {
  final User user;
  UserTypeFinder(this.user);
  @override
  _UserTypeFinderState createState() => _UserTypeFinderState();
}

class _UserTypeFinderState extends State<UserTypeFinder> {
  String userType;
  final AuthService _auth = AuthService();

  List<String> quotes = [
    "Drink daily 3-4 litters of water",
    "Exercise at least 1h daily",
    "Eat fresh foods packed with vitamins and minerals"
  ];
  final _random = new Random();
  var element;
  var opac = 1.0;

  @override
  UserTypeFinder get widget => super.widget;
  @override
  void initState() {
    element = quotes[_random.nextInt(quotes.length)];
    print(element);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Dashboard"),
        actions: [
          FlatButton.icon(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(
                Icons.exit_to_app,
                color: Colors.white,
              ),
              label: Text(
                'Log Out',
                style: TextStyle(color: Colors.white),
              ))
        ],
      ),
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 50),
          child: FutureBuilder<String>(
            future: _auth.getSpecie(widget.user.uid),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                final currUserType = snapshot.data;
                if (currUserType != "Patient") {
                  opac = 0.0;
                }
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Center(
                      child: Text(
                        "User is of " + currUserType + " type",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      ),
                    ),
                    RaisedButton.icon(
                      padding: EdgeInsets.all(10.0),
                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
                      icon: Icon(
                        Icons.refresh,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        if (currUserType == "Patient") {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorCategory()));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => DoctorDashboard()));
                        }
                      },
                      label: Text(
                        'Go to your dashboad',
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                      color: Colors.blue,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Opacity(
                      opacity: opac,
                      child: Center(
                          child: Text(
                        "Tip Of The Day",
                        style: TextStyle(color: Colors.black, fontSize: 18),
                      )),
                    ),
                    Opacity(
                      opacity: opac,
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: borderRadius),
                        child: Center(
                            child: Text(
                          element,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                        )),
                      ),
                    ),
                  ],
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
