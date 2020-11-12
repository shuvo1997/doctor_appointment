import 'package:doctorappointment/Screens/Payment.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:doctorappointment/shared/constants.dart';

class DoctorProfile extends StatefulWidget {
  final String name;
  final String expertise;
  final String chamber;
  final String address;
  final String time;
  final String qualification;

  DoctorProfile(
      {this.name,
      this.expertise,
      this.address,
      this.chamber,
      this.time,
      this.qualification});

  @override
  _DoctorProfileState createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  CalendarController _calendarController;
  DateTime _selectedDate = DateTime.now();
  bool dateflag = true;

  @override
  DoctorProfile get widget => super.widget;

  @override
  void initState() {
    _calendarController = CalendarController();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 75,
                backgroundImage: AssetImage('assets/images/doctor.png'),
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                widget.name,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.expertise,
                style: TextStyle(fontSize: 18, letterSpacing: 2.0),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.qualification,
                style: TextStyle(
                  fontSize: 18,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Text(
                widget.chamber,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black, width: 3.0),
                    borderRadius: BorderRadius.circular(10.0)),
                child: ExpansionTile(
                  childrenPadding: EdgeInsets.all(10.0),
                  children: [
                    Text(
                      widget.address,
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ],
                  leading: Icon(
                    Icons.home,
                    color: Colors.black,
                  ),
                  title: Text(
                    'Address',
                    style: TextStyle(color: Colors.black),
                  ),
                  trailing: Icon(
                    Icons.arrow_drop_down,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
              SizedBox(
                height: 15,
              ),
              _expandableCalender(),
              SizedBox(
                height: 10,
              ),
              _dateShower(),
              SizedBox(
                height: 10,
              ),
              _timeShower(),
              SizedBox(
                height: 10,
              ),
              RaisedButton.icon(
                padding: EdgeInsets.all(10.0),
                shape: RoundedRectangleBorder(borderRadius: borderRadius),
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                onPressed: () =>
                    _onButtonPressed(context, _selectedDate, widget.time),
                label: Text(
                  'Take Appointment',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                color: Colors.blue,
              )
            ],
          ),
        ),
      ),
    );
  }

  _onButtonPressed(context, DateTime dateTime, String time) {
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
              " at  " +
              time,
          buttons: [
            DialogButton(
                child: Text(
                  'YES',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => Payment(
                                doctorName: widget.name,
                                address: widget.address,
                                chamber: widget.chamber,
                                time: widget.time,
                                dateTime: _selectedDate,
                              )));
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
      'Time: ' + widget.time,
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
    return Container(
      decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 3.0),
          borderRadius: BorderRadius.circular(10.0)),
      child: ExpansionTile(
        leading: Icon(
          Icons.calendar_today,
          color: Colors.black,
        ),
        title: Text(
          'Tap here to view calender',
          style: TextStyle(color: Colors.black),
        ),
        trailing: Icon(
          Icons.arrow_drop_down,
          color: Colors.black,
          size: 30,
        ),
        children: [_buildTableCalender()],
      ),
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
