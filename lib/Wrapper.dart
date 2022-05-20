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

  @override
  UserTypeFinder get widget => super.widget;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
//    userType = _auth.getSpecie(widget.user.uid) as String;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'My Device',
        home: Scaffold(
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
          body: FutureBuilder<String>(
            future: _auth.getSpecie(widget.user.uid),
            builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
              if (!snapshot.hasData) {
                return CircularProgressIndicator();
              } else {
                final currUserType = snapshot.data;
                return Center(
                  child: Column(
                    children: [
                      Text("User is type " + currUserType),
                      RaisedButton.icon(
                        padding: EdgeInsets.all(10.0),
                        shape:
                            RoundedRectangleBorder(borderRadius: borderRadius),
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
                    ],
                  ),
                );
              }
            },
          ),
        ));
  }
}
