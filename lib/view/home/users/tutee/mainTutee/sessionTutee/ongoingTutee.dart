// ignore_for_file: prefer_const_declarations, sort_child_properties_last, prefer_const_constructors

import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
// import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/widgetSessionTutee.dart';

class OngoingTutee extends StatefulWidget {
  @override
  _OngoingTuteeState createState() => _OngoingTuteeState();
}

class _OngoingTuteeState extends State<OngoingTutee> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<List<Session>>(context);
    final String hd = 'ONGOING';

    // Use `where()` to filter ongoing sessions
    final sessionData = session.where((element) => element.status == 'accept').toList();

    if (sessionData.isNotEmpty) {
      return Scaffold(
        backgroundColor: yl,
        appBar: PreferredSize(
          child: Header(hd: hd, bl: bl, wy: wy),
          preferredSize: Size.fromHeight(80.0),
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
                    return CircularProgressIndicator(); // Display loading while waiting for data
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error loading profile'));
                  } else if (!snapshot.hasData) {
                    return CircularProgressIndicator();
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
