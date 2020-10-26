import 'package:doctorappointment/Screens/Payment.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

class DoctorProfile extends StatefulWidget {
  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  List<Icon> rating = [];
  CalendarController _calendarController;
  DateTime _selectedDate = DateTime.now();
  bool dateflag = true;
  void ratingBuilder() {
    for (int i = 0; i < 5; i++) {
      rating.add(ratingIcon());
    }
  }

  @override
  void initState() {
    ratingBuilder();
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  Widget ratingIcon() {
    return Icon(
      Icons.star,
      color: Colors.yellow[600],
    );
  }

  void _onDaySelected(DateTime day, List events, List holidays) {
    _selectedDate = day;
    setState(() {
      _dateShower();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Profile')),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/doctor.png'),
              ),
              Text(
                'Doctor Name',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Text(
                'Area of specialization',
                style: TextStyle(fontSize: 18),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: rating,
              ),
              _expandableCalender(),
              _dateShower(),
              _timeShower(),
              FlatButton(
                onPressed: () => _onButtonPressed(context, _selectedDate),
                child: Text('Take Appointment'),
                color: Colors.red,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onButtonPressed(context, DateTime dateTime) {
    if (dateflag) {
      Alert(
          context: context,
          type: AlertType.warning,
          title: "Confirmation",
          desc: "Are you sure you want to take appointment on " +
              dateTime.year.toString() +
              "-" +
              dateTime.month.toString() +
              "-" +
              dateTime.day.toString() +
              " at 7:00PM",
          buttons: [
            DialogButton(
                child: Text(
                  'YES',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Payment()));
                })
          ]).show();
    } else {
      Alert(
        context: context,
        type: AlertType.error,
        title: "Invaid Date",
        desc: "The date you selected is invalid.",
      ).show();
    }
  }

  Widget _timeShower() {
    return Text(
      'Time: 7PM',
      style: TextStyle(fontSize: 20),
    );
  }

  Widget _dateShower() {
    DateTime today = DateTime.now();
    if ((_selectedDate.month > today.month && _selectedDate.day < today.day) ||
        (_selectedDate.month >= today.month &&
            _selectedDate.day >= today.day)) {
      dateflag = true;
      return Text(
        'Selected Date is: ' +
            _selectedDate.year.toString() +
            '-' +
            _selectedDate.month.toString() +
            '-' +
            _selectedDate.day.toString(),
        style: TextStyle(fontSize: 20),
      );
    }
    if (_selectedDate.month < today.month || _selectedDate.day < today.day) {
      dateflag = false;
      return Text(
        'Select a valid date',
        style: TextStyle(fontSize: 20, color: Colors.red),
      );
    }
  }

  Widget _expandableCalender() {
    return ExpansionTile(
      title: Text(
        'Pick a date from below',
      ),
      children: [_buildTableCalender()],
    );
  }

  Widget _buildTableCalender() {
    return TableCalendar(
      calendarController: _calendarController,
      startingDayOfWeek: StartingDayOfWeek.friday,
      calendarStyle: CalendarStyle(
          selectedColor: Colors.deepOrange[400],
          todayColor: Colors.deepOrange[200],
          markersColor: Colors.brown,
          outsideDaysVisible: false),
      headerStyle: HeaderStyle(
          formatButtonTextStyle:
              TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
          formatButtonDecoration: BoxDecoration(
              color: Colors.deepOrange[400],
              borderRadius: BorderRadius.circular(16.0))),
      onDaySelected: _onDaySelected,
    );
  }
}
