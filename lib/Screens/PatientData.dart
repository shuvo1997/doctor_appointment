import 'package:doctorappointment/Services/auth.dart';
import 'package:doctorappointment/Services/database.dart';
import 'package:doctorappointment/models/user.dart';
import 'package:doctorappointment/shared/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:doctorappointment/shared/loading.dart';

class PatientData extends StatefulWidget {
  String name;
  String email;
  String uid;
  PatientData({this.name, this.email, this.uid});
  @override
  _PatientDataState createState() => _PatientDataState();
}

class _PatientDataState extends State<PatientData> {
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String month = '';
  String scale = '';

  Future<String> getUser() async {
    final FirebaseUser user = await auth.currentUser();
    return user.uid;
  }

  @override
  PatientData get widget => super.widget;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Patient Data"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 20, horizontal: 50),
            child: Column(
              children: [
                Text(widget.name),
                Text(widget.email),
                Form(
                    key: _formKey,
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Update Scale'),
                          validator: (val) =>
                              val.isEmpty ? 'Enter Scale' : null,
                          onChanged: (val) {
                            setState(() => scale = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        TextFormField(
                          decoration: textInputDecoration.copyWith(
                              labelText: 'Update Month '),
                          validator: (val) =>
                              val.isEmpty ? 'Enter Month' : null,
                          onChanged: (val) {
                            setState(() => month = val);
                          },
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        RaisedButton.icon(
                            padding: EdgeInsets.all(10.0),
                            color: Colors.blue,
                            shape: RoundedRectangleBorder(
                                borderRadius: borderRadius),
                            onPressed: () async {
                              if (_formKey.currentState.validate()) {
                                String curr_uid = await getUser();
                                print("Current User: " + curr_uid);
                                await DatabaseService(uid: curr_uid)
                                    .updateDiabetesData(
                                        widget.uid, month, scale);
                              }
                            },
                            icon: Icon(
                              Icons.app_registration,
                              color: Colors.white,
                            ),
                            label: Text(
                              'Update Data',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//              return Column(
//                children: [
//                  SizedBox(
//                    height: 100,
//                  ),
//                  RaisedButton.icon(
//                      padding: EdgeInsets.all(10.0),
//                      shape: RoundedRectangleBorder(borderRadius: borderRadius),
//                      onPressed: () {},
//                      icon: Icon(
//                        Icons.add,
//                        color: Colors.white,
//                      ),
//                      label: Text(
//                        'Add Patient Data',
//                        style: TextStyle(color: Colors.white, fontSize: 18),
//                      ),
//                      color: Colors.blue),
//                  Container(
//                    color: Colors.white,
//                    padding: EdgeInsets.all(20.0),
//                    child: Table(
//                      border: TableBorder.all(color: Colors.black),
//                      children: [
//                        TableRow(children: [
//                          Text("Cell 1"),
//                          Text("Cell 2"),
//                          Text("Cell 3"),
//                        ]),
//                        TableRow(children: [
//                          Text("Cell 1"),
//                          Text("Cell 2"),
//                          Text("Cell 3"),
//                        ])
//                      ],
//                    ),
//                  )
//                ],
//              );
