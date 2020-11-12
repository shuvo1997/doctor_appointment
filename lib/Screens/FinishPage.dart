import 'package:doctorappointment/Screens/DoctorCategory.dart';
import 'package:flutter/material.dart';
import 'package:doctorappointment/shared/constants.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:flutter/services.dart';

//flutter build apk --target-platform android-arm,android-arm64,android-x64 --split-per-abi

class FinishPage extends StatefulWidget {
  @override
  _FinishPageState createState() => _FinishPageState();
}

class _FinishPageState extends State<FinishPage> {
  final AuthService _auth = AuthService();

  void _moveToHomePage() {
    Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
  }

  void _moveTosigninPage() {
    Navigator.pushNamedAndRemoveUntil(context, "/signin", (r) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 10,
            ),
            Text(
              'Your appointment has been taken',
              style: TextStyle(fontSize: 20, letterSpacing: 2),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'An email has been sent to your',
              style: TextStyle(fontSize: 20, letterSpacing: 2),
            ),
            Text(
              'email address',
              style: TextStyle(fontSize: 20, letterSpacing: 2),
            ),
            Text(
              'Please check your email',
              style: TextStyle(fontSize: 20, letterSpacing: 2),
            ),
            Container(
                width: MediaQuery.of(context).size.width / 2,
                height: MediaQuery.of(context).size.height / 2,
                child: Image(
                  image: AssetImage('assets/images/Verified.png'),
                )),
            Text(
              'Thank You',
              style: TextStyle(fontSize: 40, letterSpacing: 10),
            ),
            Text(
              'For using our app',
              style: TextStyle(fontSize: 20, letterSpacing: 3),
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton.icon(
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              icon: Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                _moveToHomePage();
              },
              label: Text(
                'Take Another Appointment',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Colors.blue,
            ),
            SizedBox(
              height: 10,
            ),
            RaisedButton.icon(
              padding: EdgeInsets.all(10.0),
              shape: RoundedRectangleBorder(borderRadius: borderRadius),
              icon: Icon(
                Icons.logout,
                color: Colors.white,
              ),
              onPressed: () {
                SystemNavigator.pop();
              },
              label: Text(
                'Exit App',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}
