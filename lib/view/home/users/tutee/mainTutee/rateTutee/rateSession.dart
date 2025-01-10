// ignore_for_file: prefer_const_constructors

// import 'package:flutter_application_1/model/global.dart';
// import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter/material.dart';

class RateSession extends StatefulWidget {
  @override
  _RateSessionState createState() => _RateSessionState();
}

class _RateSessionState extends State<RateSession> {
  final String hd = 'Feedback';

  // Form validation key
  final _formKey = GlobalKey<FormState>();

  final TextStyle _label = TextStyle(
    color: Colors.black,
    fontSize: 14,
  );

  String fd = ''; // Feedback field to capture user input

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(hd),
      content: Form(
        key: _formKey, // Link form to the validation key
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextFormField(
              maxLines: 5,
              decoration: InputDecoration(
                labelStyle: _label,
                labelText: 'Enter your feedback about the tutor',
                border: OutlineInputBorder(),
              ),
              validator: (val) => val == null || val.isEmpty
                  ? 'You cannot submit an empty form!'
                  : null,
              onChanged: (val) {
                setState(() => fd = val); // Store feedback in the fd variable
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black, // Button color
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                padding: EdgeInsets.symmetric(vertical: 18),
              ),
              child: Text(
                'Submit',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15.0,
                  letterSpacing: 1.5,
                ),
              ),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  // Perform submit action, e.g., save feedback to database
                  print('Feedback submitted: $fd');
                  Navigator.of(context).pop(); // Close the dialog after submission
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
