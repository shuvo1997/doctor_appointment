import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class MailService {
  sendMail(String email) async {
    String username = 'shuvoauto@gmail.com';
    String password = 'sukumar123';

    final smtpServer = gmail(username, password);

    final message = Message()
      ..from = Address(username, 'Doctor Appointment')
      ..recipients.add(email)
      ..subject = 'Doctor Appointment Notification'
      ..html =
          "<h1>You Have An Appointment</h1>\n<p>Hello ,You have an appointment on </p>";

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
