import 'package:flutter/material.dart';

class Payment extends StatefulWidget {
  @override
  _PaymentState createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  List<Card> logos = [];
  List<String> imageNames = [
    'bkash.png',
    'rocket.png',
    'nagad.png',
    'visa.png'
  ];

  _buildPaymentCards() {
    for (int i = 0; i < 4; i++) {
      logos.add(_paymentCard('assets/images/' + imageNames[i]));
    }
  }

  @override
  void initState() {
    _buildPaymentCards();
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
          child: Column(
            children: [
              Text(
                'To continue please pay 100tk using these payment methods',
                style: TextStyle(fontSize: 20),
              ),
              Flexible(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: logos,
                ),
              ),
            ],
          ),
        ));
  }

  Widget _paymentCard(String string) {
    return Card(
      semanticContainer: true,
      child: InkWell(
        onTap: () {
          print(string);
        },
        child: Image.asset(string),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      elevation: 5,
      margin: EdgeInsets.all(10),
    );
  }
}
