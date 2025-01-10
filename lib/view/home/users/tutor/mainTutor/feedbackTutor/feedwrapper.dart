// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/controller/feeddata.dart';
import 'package:flutter_application_1/model/feedback.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/feedbackTutor/feedbackTutor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FeedWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile?>(context);

    // Check if the profile is null
    if (profile == null) {
      return Center(child: Text('Profile data not available.'));
    }

    return StreamProvider<FeedList?>.value(
      initialData: null, // Provide an initial value in case the stream hasn't emitted yet
      value: FeedDataService(uid: profile.uid).feedback,
      catchError: (context, error) {
        // Handle the error (optional)
        print('Error in StreamProvider: $error');
        return null; // Return null or an appropriate default value
      },
      child: FeedbackTutor(),
    );
  }
}
