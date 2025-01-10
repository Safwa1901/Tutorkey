// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/users/tutee/dashboardTutee.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/historyTutee.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/unpaidTutee.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/ongoingTutee.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/pendingTutee.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/rejectTutee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestWrapperTutee extends StatelessWidget {
  final String destination;

  TestWrapperTutee({Key? key, required this.destination}) : super(key: key);

  Widget thePage(String ds) {
    switch (ds) {
      case 'pending':
        return PendingTutee();
      case 'accept':
        return OngoingTutee();
      case 'unpaid':
        return UnpaidTutee();
      case 'complete':
        return HistoryTutee();
      case 'reject':
        return RejectTutee();
      default:
        return DashboardTutee(); // Ensure this is a valid fallback
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile?>(context);

    if (profile == null) {
      // Handle null profile case here, e.g., show an error message or redirect
      return Center(child: Text('Profile not found'));
    }

    return StreamProvider<List<Session>>.value(
      value: TutorDataService(id: profile.uid).sessiontutee,
      initialData: [], // Provide an initial empty list to avoid null errors
      catchError: (context, error) {
        // Handle any errors from the stream
        return [];
      },
      child: thePage(destination),
    );
  }
}
