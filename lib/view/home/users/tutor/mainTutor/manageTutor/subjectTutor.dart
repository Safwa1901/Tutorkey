// ignore_for_file: prefer_const_constructors, sort_child_properties_last, sized_box_for_whitespace

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/subjectdata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';

class SubjectTutor extends StatefulWidget {
  @override
  _SubjectTutorState createState() => _SubjectTutorState();
}
class _SubjectTutorState extends State<SubjectTutor> {
  late List<bool> _subjectState;

  @override
  void initState() {
    super.initState();

    // Ensure subjectList is not null and initialize _subjectState
    _subjectState = subjectList != null ? List<bool>.filled(subjectList.length, false) : [];
  }

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    const String headerText = 'Subject';

    // Safely update _subjectState based on profile subjects
    for (int i = 0; i < subjectList.length; i++) {
      _subjectState[i] = profile.subject?.contains(subjectList[i].title.toLowerCase()) ?? false;
    }

    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        child: Header(hd: headerText, bl: bl, wy: wy),
        preferredSize: Size.fromHeight(80.0),
      ),
      body: Container(
        // color: wy,
        padding: EdgeInsets.only(top: 20, left: 10, right: 8),
        decoration: BoxDecoration(
          color: yl,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
        ),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Center(
                child: Text('Please click subject you teach until it turns green'),
              ),
            ),
            Expanded(
              child: GridView.builder(
                itemCount: subjectList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 18,
                  mainAxisSpacing: 10,
                  childAspectRatio: 2,
                ),
                itemBuilder: (context, index) {
                  return FilterChip(
                    selectedColor: _subjectState[index] ? gn : rd,
                    backgroundColor: _subjectState[index] ? gn : rd,
                    selected: _subjectState[index],
                    label: Container(
                      width: 100,
                      child: Text(
                        subjectList[index].title,
                        style: TextStyle(fontSize: 15),
                      ),
                    ),
                    padding: EdgeInsets.all(30),
                    onSelected: (bool selected) async {
                      setState(() {
                        _subjectState[index] = selected;
                      });

                      try {
                        if (selected) {
                          // Add subject to tutor's subjects
                          await SubjectDataService(uid: profile.uid).addSubjectTutorSPM(
                            profile.fullName,
                            profile.image,
                            subjectList[index].title.toLowerCase(),
                            profile.price,
                          );
                          // Update profile with new subject
                          await ProfileDataService(uid: profile.uid)
                              .updateSubject(subjectList[index].title.toLowerCase());
                        } else {
                          // Remove subject from tutor's subjects
                          await SubjectDataService(uid: profile.uid)
                              .deleteSubjectTutorSPM(subjectList[index].title.toLowerCase());
                          // Update profile to remove subject
                          await ProfileDataService(uid: profile.uid)
                              .deleteSubject(subjectList[index].title.toLowerCase());
                        }
                      } catch (e) {
                        // Handle error (e.g., show a snack bar or alert)
                        print("Error updating subject: $e");
                      }
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
