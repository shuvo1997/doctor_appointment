import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctorappointment/Screens/DoctorProfile.dart';
import 'package:doctorappointment/Screens/UserScreen.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:doctorappointment/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:doctorappointment/Services/database.dart';
import 'package:provider/provider.dart';

class DoctorList extends StatefulWidget {
  final String category;
  DoctorList({this.category});

  @override
  _DoctorListState createState() => _DoctorListState();
}

class _DoctorListState extends State<DoctorList> {
  final AuthService _auth = new AuthService();

  @override
  DoctorList get widget => super.widget;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Doctor List'),
        ),
        body: StreamBuilder(
          stream: Firestore.instance.collection(widget.category).snapshots(),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Loading();
            }
            return ListView(
              children: snapshot.data.documents.map((document) {
                return ListItem(
                    document['Name'],
                    document['Expertise'],
                    document['Chamber'],
                    document['Address'],
                    document['Qualification'],
                    document['Time'],
                    true);
              }).toList(),
            );
          },
        ));
  }

  Widget ListItem(String name, String expertise, String chamber, String address,
      String qualification, String time, bool active) {
    return ListTile(
      leading: CircleAvatar(
        radius: 25,
        backgroundImage: AssetImage('assets/images/doctor.png'),
      ),
      title: Text(name),
      subtitle: Text(expertise),
      trailing: Icon(Icons.keyboard_arrow_right),
      enabled: active,
      onTap: () {
        if (active) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorProfile(
                        name: name,
                        expertise: expertise,
                        address: address,
                        chamber: chamber,
                        time: time,
                        qualification: qualification,
                      )));
        }
      },
    );
  }
}
