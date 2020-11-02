import 'package:doctorappointment/Services/Mailer.dart';
import 'package:doctorappointment/Services/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class Payment extends StatefulWidget {
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
          padding: const EdgeInsets.all(15.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'To continue please pay 100tk using these payment methods',
                  style: TextStyle(fontSize: 20),
                ),
                MyCard(string: 'assets/images/bkash.png'),
                MyCard(string: 'assets/images/nagad.png'),
                MyCard(string: 'assets/images/rocket.png'),
                MyCard(string: 'assets/images/visa.png'),
              ],
            ),
          ),
        ));
  }
}

class MyCard extends StatelessWidget {
  final String string;
  MyCard({this.string});

  String email = '';

  MailService _mailer = new MailService();

  _onPaymentButtonClick(String email) {
    _mailer.sendMail(email);
    print('email sent');
  }

  Future getEmailId() async {
    FirebaseUser user = await FirebaseAuth.instance.currentUser();
    email = user.email;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      semanticContainer: true,
      child: InkWell(
        onTap: () async {
          await getEmailId();
          print(email);
          await _onPaymentButtonClick(email);
          Scaffold.of(context).showSnackBar(SnackBar(
              content: Text('Yay! An email has been sent to ' + email)));
        },
        child: Image.asset(string),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
