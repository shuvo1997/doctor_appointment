import 'package:doctorappointment/Screens/DoctorList.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:doctorappointment/shared/constants.dart';
import 'package:flutter/material.dart';

class DoctorCategory extends StatefulWidget {
  @override
  _DoctorCategoryState createState() => _DoctorCategoryState();
}

class _DoctorCategoryState extends State<DoctorCategory> {
  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Category'),
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryButton('Cardiologists'),
              CategoryButton('Neurologists')
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CategoryButton('Gastroenterologist'),
              CategoryButton('Nephrologists')
            ],
          )
        ],
      ),
    );
  }

  Widget CategoryButton(String category) {
    String logo = '';
    if (category == 'Cardiologists') {
      logo = 'cardio2.png';
    } else if (category == 'Neurologists') {
      logo = 'neuro1.png';
    } else if (category == 'Gastroenterologist') {
      logo = 'gastro.png';
    } else {
      logo = 'Nephro.png';
    }
    return RaisedButton(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: borderRadius),
      onPressed: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DoctorList(
                      category: category,
                    )));
      },
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            Container(
                width: MediaQuery.of(context).size.width / 4,
                height: MediaQuery.of(context).size.height / 4,
                child: Image(
                  image: AssetImage('assets/images/' + logo),
                )),
            Text(
              category,
              style: TextStyle(fontSize: 15),
            ),
          ],
        ),
      ),
    );
  }
}
