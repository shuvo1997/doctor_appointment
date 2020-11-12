import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailService {
  sendMail(String email, String doctorName, String chamber, String address,
      String time, DateTime dateTime) async {
    String username = 'shuvoauto@gmail.com';
    String password = 'sukumar123';

    print(address);
    String text =
        "<h3>Appointment</h3>Hello Sir,<br> You have an appointment with " +
            doctorName +
            " on " +
            dateTime.day.toString() +
            "/" +
            dateTime.month.toString() +
            "/" +
            dateTime.year.toString() +
            " " +
            time +
            ". Please make sure you reach at " +
            chamber +
            " situated at " +
            address +
            "." +
            "<br> Thank you.";

    final smtpServer = gmail(username, password);

    print(doctorName);
    final message = Message()
      ..from = Address(username, 'Doctor Appointment')
      ..recipients.add(email)
      ..subject = 'Doctor Appointment Notification'
      ..html = text;

    try {
      final sendReport = await send(message, smtpServer);
      print('Message Sent: ' + sendReport.toString());
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}
