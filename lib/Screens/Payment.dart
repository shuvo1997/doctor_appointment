import 'package:doctorappointment/Screens/FinishPage.dart';
import 'package:doctorappointment/Services/Mailer.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Payment extends StatefulWidget {
  final String doctorName;
  final DateTime dateTime;
  final String chamber;
  final String address;
  final String time;
  Payment(
      {this.doctorName, this.dateTime, this.address, this.chamber, this.time});
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<MyCard> logos = [];
  List<String> imageNames = [
    'bkash.png',
    'rocket.png',
    'nagad.png',
    'visa.png'
  ];

  @override
  Payment get widget => super.widget;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text('Payment')),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.blue, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                padding: EdgeInsets.all(10),
                child: Text(
                  'To continue please pay 10% of doctor fee using these payment methods',
                  style: TextStyle(fontSize: 20, color: Colors.black),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCard(
                    string: 'assets/images/bkash.png',
                    doctorName: widget.doctorName,
                    time: widget.time,
                    address: widget.address,
                    chamber: widget.chamber,
                    dateTime: widget.dateTime,
                  ),
                  MyCard(
                    string: 'assets/images/nagad.png',
                    doctorName: widget.doctorName,
                    time: widget.time,
                    address: widget.address,
                    chamber: widget.chamber,
                    dateTime: widget.dateTime,
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyCard(
                    string: 'assets/images/rocket.png',
                    doctorName: widget.doctorName,
                    time: widget.time,
                    address: widget.address,
                    chamber: widget.chamber,
                    dateTime: widget.dateTime,
                  ),
                  MyCard(
                    string: 'assets/images/visa.png',
                    doctorName: widget.doctorName,
                    time: widget.time,
                    address: widget.address,
                    chamber: widget.chamber,
                    dateTime: widget.dateTime,
                  ),
                ],
              ),
            ],
          ),
        ));
  }
}

class MyCard extends StatelessWidget {
  final String string;
  final String doctorName;
  final DateTime dateTime;
  final String chamber;
  final String address;
  final String time;
  MyCard(
      {this.doctorName,
      this.dateTime,
      this.address,
      this.chamber,
      this.time,
      this.string});

  String email = '';

  MailService _mailer = new MailService();

  _onPaymentButtonClick(String email) {
    _mailer.sendMail(email, doctorName, chamber, address, time, dateTime);
    print('email sent');
  }

  Future getEmailId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width / 2.2,
      height: MediaQuery.of(context).size.width / 2,
      child: Card(
        semanticContainer: true,
        child: InkWell(
          onTap: () async {
            await getEmailId();
            print(email);
            await _onPaymentButtonClick(email);
            Scaffold.of(context).showSnackBar(SnackBar(
                content: Text('Yay! An email has been sent to ' + email)));
            Navigator.pushNamedAndRemoveUntil(context, "/finish", (r) => false);
          },
          child: Image.asset(string),
        ),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        elevation: 5,
        margin: EdgeInsets.all(10),
      ),
    );
  }
}
