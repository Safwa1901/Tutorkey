import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/users/tutee/dashboardTutee.dart';
// import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/historyTutee.dart';
// import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/ongoingTutee.dart';
// import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/pendingTutee.dart';
// import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/rejectTutee.dart';
// import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/unpaidTutee.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/historyTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/rejectTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/unpaidTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/ongoingTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/pendingTutor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TestWrapperTutor extends StatelessWidget {
  final String? destination; // Make destination nullable

  TestWrapperTutor({Key? key, this.destination}) : super(key: key);

  Widget thePage(String? ds) {
    switch (ds) {
      case 'pending':
        return PendingTutor();

      case 'accept':
        return OngoingTutor();

      case 'unpaid':
        return UnpaidTutor();

      case 'complete':
        return HistoryTutor();

      case 'reject':
        return RejectTutor();

      default:
        return DashboardTutee();
    }
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return StreamProvider<List<Session>>.value(
      value: TutorDataService(id: profile.uid).sessiontutor,
      initialData: [], // Provide an initial value to avoid nulls
      child: thePage(destination), // Call the page function
    );
  }
}
