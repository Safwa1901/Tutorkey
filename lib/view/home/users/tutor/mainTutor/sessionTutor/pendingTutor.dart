// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_declarations

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
//import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/widgetSessionTutor.dart';

class PendingTutor extends StatefulWidget {
  @override
  _PendingTutorState createState() => _PendingTutorState();
}

class _PendingTutorState extends State<PendingTutor> {
  @override
  Widget build(BuildContext context) {
    // Use List<Session> for better type safety
    final List<Session> session = Provider.of<List<Session>>(context);
    final List<Session> sessionData = []; // Initialize an empty list
    final String hd = 'PENDING';

    // Filter sessions based on their status
    for (var element in session) {
      if (element.status == 'pending') {
        sessionData.add(element);
      }
    }

    if (sessionData.isNotEmpty) {
      return Scaffold(
        backgroundColor: yl,
        appBar: PreferredSize(
          child: Header(hd: hd, bl: bl, wy: wy),
          preferredSize: Size.fromHeight(80.0),
        ),
        body: Container(
          color: wy,
          child: Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 8,
            ),
            decoration: BoxDecoration(
              color: yl,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: ListView.builder(
              itemCount: sessionData.length,
              itemBuilder: (context, index) {
                return StreamBuilder<Profile>(
                  stream: ProfileDataService(uid: sessionData[index].tuteeId).profile,  // Fix: Use sessionData[index].tuteeId
                  builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Loading indicator
                    }
                    if (snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: wy,
                          borderRadius: BorderRadius.all(
                            Radius.circular(15),
                          ),
                        ),
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: Column(
                                children: <Widget>[
                                  Text(
                                    sessionData[index].subject.toUpperCase(),
                                    style: sb,
                                  ),
                                  SizedBox(height: 20),
                                  ProfileDisplay(
                                      snapshot: snapshot,
                                      sessionData: sessionData,
                                      index: index),
                                  SizedBox(height: 25),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: gn, // Background color
                                          ),
                                          child: Text('Accept'),
                                          onPressed: () async {
                                            // Fix: Pass the tutorId when creating the TutorDataService instance
                                            await TutorDataService(id: sessionData[index].tutorId)
                                                .updateTutorSessionData(
                                                    sessionData[index].id,  // Use sessionData[index].id
                                                    'accept');
                                          },
                                        ),
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: rd, // Background color
                                          ),
                                          child: Text('Reject'),
                                          onPressed: () async {
                                            // Fix: Pass the tutorId when creating the TutorDataService instance
                                            await TutorDataService(id: sessionData[index].tutorId)
                                                .updateTutorSessionData(
                                                    sessionData[index].id,  // Use sessionData[index].id
                                                    'reject');
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy);
                    }
                  },
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy);
    }
  }
}
