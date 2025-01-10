import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/users/tutee/dashboardTutee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SessionWrapperTutee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile?>(context);

    // Handle the case when profile is null (e.g., not yet loaded)
    if (profile == null) {
      print("profile notnotnotnotnotnot availabel");
      return Center(child: CircularProgressIndicator()); // Or a loading screen
    }
print(profile);
    return StreamProvider<List<Session>?>.value(
      value: TutorDataService(id: profile.uid).sessiontutee,
      initialData: null, // Provide initial data or null if stream hasn't emitted yet
      child: DashboardTutee(),
      catchError: (_, __) => null, // Handle potential errors in the stream
    );
  }
}
