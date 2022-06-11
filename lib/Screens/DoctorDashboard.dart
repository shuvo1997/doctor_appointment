import 'package:doctorappointment/Screens/PatientData.dart';
import 'package:doctorappointment/shared/constants.dart';
import 'package:doctorappointment/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DoctorDashboard extends StatefulWidget {
  @override
  _DoctorDashboardState createState() => _DoctorDashboardState();
}

class _DoctorDashboardState extends State<DoctorDashboard> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Hospital Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          appBar: AppBar(
            title: Text("Dashboard"),
          ),
          body: StreamBuilder(
              stream: Firestore.instance.collection('users').snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData) {
                  return Loading();
                }
                return ListView(
                  children: snapshot.data.documents.map((document) {
                    return ListItem(document['name'], document['email'],
                        document.documentID, true);
                  }).toList(),
                );
              }),
        ));
  }

  Widget ListItem(String name, String email, String uid, bool active) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/doctor_appointment.png'),
      ),
      title: Text(name),
      subtitle: Text(email),
      trailing: Icon(Icons.keyboard_arrow_right),
      enabled: active,
      onTap: () {
        if (active) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PatientData(
                        name: name,
                        email: email,
                        uid: uid,
                      )));
        }
      },
    );
  }
}
