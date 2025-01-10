// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/widgetSessionTutee.dart';

class UnpaidTutee extends StatefulWidget {
  @override
  _UnpaidTuteeState createState() => _UnpaidTuteeState();
}

class _UnpaidTuteeState extends State<UnpaidTutee> {
  @override
  Widget build(BuildContext context) {
    final sessions = Provider.of<List<Session>>(context);
    final String hd = 'UNPAID';

    // Filter the sessions based on status
    final unpaidSessions = sessions.where((element) => element.status == 'attend').toList();

    if (unpaidSessions.isEmpty) {
      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy);
    }

    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Header(hd: hd, bl: bl, wy: wy),
      ),
      body: Container(
        color: wy,
        child: Container(
          padding: const EdgeInsets.only(
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
            itemCount: unpaidSessions.length,
            itemBuilder: (context, index) {
              final session = unpaidSessions[index];

              return StreamBuilder<Profile>(
                stream: ProfileDataService(uid: session.tutorId).profile,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading(); // Show loading while waiting for data
                  }
                  if (!snapshot.hasData) {
                    return const Center(child: Text('Error loading profile'));
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: wy,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Container(
                          padding: const EdgeInsets.fromLTRB(30, 20, 30, 30),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              Text(
                                session.subject.toUpperCase(),
                                style: sb,
                              ),
                              const SizedBox(height: 20),
                              ProfileDisplay(
                                snapshot: snapshot,
                                sessionData: unpaidSessions,
                                index: index,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
