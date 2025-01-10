import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
//import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/widgetSessionTutor.dart';
import 'package:flutter_application_1/model/global.dart';

class UnpaidTutor extends StatefulWidget {
  @override
  _UnpaidTutorState createState() => _UnpaidTutorState();
}

class _UnpaidTutorState extends State<UnpaidTutor> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<List<Session>>(context);
    final List<Session> sessionData = [];

    final Color yl = Color(0xffF0C742);
    final Color wy = Colors.white;
    final Color bl = Colors.black;
    final String hd = 'UNPAID';

    session.forEach((element) {
      if (element.status == 'attend') sessionData.add(element);
    });
  
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
                  stream: ProfileDataService(uid: sessionData[index].tutorId).profile,
                  builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator()); // Show a loader while fetching
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
                                    child: Container(
                                      margin: EdgeInsets.fromLTRB(0, 10, 0, 15),
                                      child: Center(
                                        child: ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.green, // Set color if needed
                                          ),
                                          child: Text('Paid'),
                                          onPressed: () async {
                                            await TutorDataService(id: session[index].tutorId).updateTutorSessionData(
                                             session[index].id, 
      'complete');

                                          },
                                        ),
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
                      return Text('Data not found'); // Handle data not found case
                    }
                  },
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy); // Handle no sessions available
    }
  }
}
