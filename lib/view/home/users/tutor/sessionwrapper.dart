import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/users/tutor/dashboardTutor.dart';
import 'package:provider/provider.dart';

class SessionWrapperTutor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);

    return StreamProvider<List<Session>>.value(
      value: TutorDataService(id: profile.uid).sessiontutor,
      initialData: [], // Set initial data to an empty list
      catchError: (_, __) => [], // Handle errors by returning an empty list
      child: DashboardTutor(),
    );
  }
}
