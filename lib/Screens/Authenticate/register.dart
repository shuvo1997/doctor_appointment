import 'package:flutter/material.dart';
import 'package:doctorappointment/shared/constants.dart';
import 'package:doctorappointment/shared/loading.dart';
import 'package:doctorappointment/Services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({this.toggleView});

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth = AuthService();

  final _formKey = GlobalKey<FormState>();

  //text field state
  String email = '';
  String password = '';
  String error = '';
  String name = '';
  String age = '';
  String blood = '';

  bool loading = false;

  @override
  Widget build(BuildContext context) {
    return loading
        ? Loading()
        : Scaffold(
            body: SafeArea(
              child: SingleChildScrollView(
                child: Container(
                  padding:
                      EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        child: Image(
                          image: AssetImage('assets/images/doctor.png'),
                        ),
                      ),
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Name'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your name' : null,
                              onChanged: (val) {
                                setState(() {
                                  name = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Age'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your age' : null,
                              onChanged: (val) {
                                setState(() {
                                  age = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Blood Group'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter your blood group' : null,
                              onChanged: (val) {
                                setState(() {
                                  blood = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Email'),
                              validator: (val) =>
                                  val.isEmpty ? 'Enter an email' : null,
                              onChanged: (val) {
                                setState(() {
                                  email = val;
                                });
                              },
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            TextFormField(
                              decoration: textInputDecoration.copyWith(
                                  labelText: 'Password'),
                              validator: (val) => val.length < 6
                                  ? 'Enter a password with 6+ charecters'
                                  : null,
                              onChanged: (val) {
                                password = val;
                              },
                              obscureText: true,
                            ),
                            SizedBox(
                              height: 20.0,
                            ),
                            RaisedButton.icon(
                              icon: Icon(
                                Icons.app_registration,
                                color: Colors.white,
                              ),
                              padding: EdgeInsets.all(10.0),
                              shape: RoundedRectangleBorder(
                                  borderRadius: borderRadius),
                              label: Text(
                                'Register',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 16),
                              ),
                              color: Colors.blue,
                              onPressed: () async {
                                if (_formKey.currentState.validate()) {
                                  setState(() {
                                    loading = true;
                                  });
                                  dynamic result =
                                      await _auth.registerWithEmailAndPassword(
                                    email,
                                    password,
                                    name,
                                    age,
                                    blood,
                                  );
                                  //Validation
                                  if (result is String) {
                                    setState(() {
                                      error = result;
                                      loading = false;
                                    });
                                  }
                                }
                              },
                            ),
                            SizedBox(
                              height: 12.0,
                            ),
                            Text(
                              error,
                              style:
                                  TextStyle(color: Colors.red, fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Already have an account?',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 18.0),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            RaisedButton.icon(
                                padding: EdgeInsets.all(10.0),
                                color: Colors.blue,
                                shape: RoundedRectangleBorder(
                                    borderRadius: borderRadius),
                                onPressed: () {
                                  widget.toggleView();
                                },
                                icon: Icon(
                                  Icons.person,
                                  color: Colors.white,
                                ),
                                label: Text(
                                  'Sign In',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }
}
