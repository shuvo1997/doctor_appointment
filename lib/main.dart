import 'package:doctorappointment/Screens/Authenticate/sign_in.dart';
import 'package:doctorappointment/Screens/DoctorCategory.dart';
import 'package:doctorappointment/Screens/FinishPage.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:doctorappointment/Wrapper.dart';
import 'package:doctorappointment/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
        home: Wrapper(),
        routes: {
          "/home": (_) => DoctorCategory(),
          "/finish": (_) => FinishPage(),
          "/signin": (_) => SignIn(),
        },
      ),
    );
  }
}
