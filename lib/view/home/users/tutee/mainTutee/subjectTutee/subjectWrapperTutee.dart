import 'package:flutter_application_1/controller/evaluatedata.dart';
import 'package:flutter_application_1/model/evaluate.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/subjectTutee/subjectTutee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SubjectWrapperTutee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context); // This will never be null
    print("reached hererererere");
  print(profile);
    return StreamProvider<List<Evaluate>>.value(
      value: EvaluateDataService(uid: profile.uid).evaluation, // Stream<List<Evaluate>>
      initialData: [], // Set initial data as an empty list
      catchError: (_, __) => [], // Handle errors by returning an empty list
      child: SubjectTutee(), // The child widget that will consume the stream
    );
  }
}
