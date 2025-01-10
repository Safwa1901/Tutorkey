// ignore_for_file: prefer_const_declarations, sort_child_properties_last, prefer_const_constructors

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
//import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/widgetSessionTutor.dart';

class OngoingTutor extends StatefulWidget {
  @override
  _OngoingTutorState createState() => _OngoingTutorState();
}

class _OngoingTutorState extends State<OngoingTutor> {
  @override
  Widget build(BuildContext context) {
    final List<Session> session = Provider.of<List<Session>>(context);
    final List<Session> sessionData = []; // Initialize an empty list
    final String hd = 'ONGOING';

    // Filter ongoing sessions
    for (var element in session) {
      if (element.status == 'accept') {
        sessionData.add(element);
      }
    }

    if (sessionData.isNotEmpty) {
      return Scaffold(
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
                // Stream for tutee profile
                return StreamBuilder<Profile>(
                  stream: ProfileDataService(uid: sessionData[index].tutorId).profile,
                  builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Show loading indicator
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
                              padding: EdgeInsets.all(30),
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
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor: gn, // Background color
                                            ),
                                            child: Text('Attended'),
                                            onPressed: () async {
                                              await TutorDataService(id: sessionData[index].tutorId)
                                                  .updateTutorSessionData(
                                                      sessionData[index].id,
                                                      'attend');
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(child: Text('Data not found'));
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
