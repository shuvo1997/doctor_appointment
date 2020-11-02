import 'package:doctorappointment/Screens/DoctorProfile.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:flutter/material.dart';

class DoctorList extends StatefulWidget {
  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final AuthService _auth = new AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Doctor List')),
        actions: [
          FlatButton.icon(
              onPressed: () {
                _auth.signOut();
              },
              icon: Icon(Icons.exit_to_app),
              label: Text('Log Out'))
        ],
      ),
      body: ListView(
        children: [
          ListItem(true),
          ListItem(true),
          ListItem(true),
          ListItem(false),
        ],
      ),
    );
  }

  Widget ListItem(bool active) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/doctor.png'),
      ),
      title: Text('Doctor Name'),
      subtitle: Text('Area of Specialization'),
      trailing: Icon(Icons.keyboard_arrow_right),
      enabled: active,
      onTap: () {
        if (active) {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => DoctorProfile()));
        }
      },
    );
  }
}
