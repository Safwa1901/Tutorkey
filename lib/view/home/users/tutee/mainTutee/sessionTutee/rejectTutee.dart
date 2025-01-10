// ignore_for_file: prefer_const_declarations, prefer_const_constructors

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';
import '../../../../loading.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/widgetSessionTutee.dart';

class RejectTutee extends StatefulWidget {
  @override
  _RejectTuteeState createState() => _RejectTuteeState();
}

class _RejectTuteeState extends State<RejectTutee> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<List<Session>>(context);
    final String hd = 'REJECTED';

    // Use `where()` method to filter rejected sessions
    final sessionData = session.where((element) => element.status == 'reject').toList();

    if (sessionData.isNotEmpty) {
      return Scaffold(
        backgroundColor: yl,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80.0),
          child: Header(hd: hd, bl: bl, wy: wy),
        ),
        body: Container(
          color: wy,
          padding: EdgeInsets.only(top: 20, left: 10, right: 8),
          decoration: BoxDecoration(
            color: yl,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          ),
          child: ListView.builder(
            itemCount: sessionData.length,
            itemBuilder: (context, index) {
              return StreamBuilder<Profile>(
                stream: ProfileDataService(uid: sessionData[index].tutorId).profile,
                builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Loading();
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading profile'));
                  } else if (!snapshot.hasData) {
                    return Loading();
                  }

                  return Container(
                    decoration: BoxDecoration(
                      color: wy,
                      borderRadius: BorderRadius.all(Radius.circular(15)),
                    ),
                    margin: EdgeInsets.all(20),
                    padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
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
                          index: index,
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          ),
        ),
      );
    } else {
      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy);
    }
  }
}
