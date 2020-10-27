import 'package:doctorappointment/Screens/Authenticate/Authenticate.dart';
import 'package:doctorappointment/Screens/DoctorList.dart';
import 'package:doctorappointment/models/user.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<User>(context);
    print(user);
    if (user == null) {
      return Authenticate();
    } else {
      return DoctorList();
    }
  }
}
