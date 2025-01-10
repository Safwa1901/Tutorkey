// ignore_for_file: unnecessary_null_comparison, prefer_const_declarations, sort_child_properties_last, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/evaluatedata.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:provider/provider.dart';

class ManageSubjectTutee extends StatefulWidget {
  @override
  _ManageSubjectTuteeState createState() => _ManageSubjectTuteeState();
}

class _ManageSubjectTuteeState extends State<ManageSubjectTutee> {
  late List<bool> _subjectState;

  @override
  Widget build(BuildContext context) {
    final String hd = 'Manage Subject';
    final profile = Provider.of<Profile>(context);

    // Initialize the subject state list based on subjectList length
    _subjectState = List<bool>.filled(subjectList.length, false);

    if (profile.subject != null) {
      for (int i = 0; i < subjectList.length; i++) {
        _subjectState[i] = profile.subject.contains(subjectList[i].title.toLowerCase());
      }
    }

    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        child: Header(hd: hd, bl: bl, wy: wy),
        preferredSize: Size.fromHeight(80.0),
      ),
      body: Container(
        color: wy,
        child: Container(
          padding: const EdgeInsets.only(top: 20, left: 10, right: 8),
          decoration: BoxDecoration(
            color: yl,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          ),
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Center(
                  child: Text(
                    'Please click the subjects you take for your exam until they turn green',
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Expanded(
                child: GridView.count(
                  childAspectRatio: 2,
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 10,
                  children: List.generate(
                    subjectList.length,
                    (index) => FilterChip(
                      selectedColor: _subjectState[index] ? gn : rd,
                      backgroundColor: _subjectState[index] ? gn : rd,
                      selected: _subjectState[index],
                      label: Container(
                        width: 100,
                        child: Text(
                          subjectList[index].title, // Change 'eng' to 'title'
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      padding: const EdgeInsets.all(30),
                      onSelected: (bool selected) async {
                        setState(() {
                          _subjectState[index] = selected;
                        });
                        if (selected) {
                          // Add in subject collection
                          await EvaluateDataService(uid: profile.uid)
                              .updateEvaluationData(
                                  subjectList[index].title.toLowerCase(), 0.0);
                          // Add in profile collection
                          await ProfileDataService(uid: profile.uid)
                              .updateSubject(subjectList[index].title.toLowerCase());
                        } else {
                          // Remove from evaluation and profile
                          await EvaluateDataService(uid: profile.uid)
                              .deleteEvaluationSubject(subjectList[index].title.toLowerCase());
                          await ProfileDataService(uid: profile.uid)
                              .deleteSubject(subjectList[index].title.toLowerCase());
                        }
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
