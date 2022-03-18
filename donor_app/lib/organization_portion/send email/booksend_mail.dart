import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class BookSendmail extends StatefulWidget {
  const BookSendmail({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _BookSendmailState createState() => _BookSendmailState();
}

class _BookSendmailState extends State<BookSendmail> {
  sendMail() async {
    String username = 'cocharitable4@gmail.com';
    String password = '!123123qwe';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username)
      ..recipients.add('recipient@gmail.com')
//      ..ccRecipients.addAll(['destCc1@example.com', 'destCc2@example.com'])
//      ..bccRecipients.add(Address('bccAddress@example.com'))
      ..subject = 'Mail using mailer package :: 😀 :: ${DateTime.now()}'
      ..text = 'This is the plain text.\nThis is line 2 of the text part.'
      ..html =
          "<h1>Write the content here</h1>\n<p>Hey! its easy use html tags for alignments</p>";

    try {
      final sendReport = await send(message, smtpServer);
      print('Message sent: ' + sendReport.toString());
      Fluttertoast.showToast(msg: "Email Sent");
    } on MailerException catch (e) {
      print('Message not sent.');
      for (var p in e.problems) {
        print('Problem: ${p.code}: ${p.msg}');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            sendMail;
          },
         
          child: Text(
            'Confirm',
            style: TextStyle(color: Colors.black, fontSize: 20.0),
          ),
          
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
