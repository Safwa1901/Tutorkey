// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_declarations

import 'package:flutter_application_1/controller/evaluatedata.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/widgetSessionTutor.dart';

class HistoryTutor extends StatefulWidget {
  @override
  _HistoryTutorState createState() => _HistoryTutorState();
}

class _HistoryTutorState extends State<HistoryTutor> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<List<Session>>(context);  // Sessions list from Firestore
    final sessionData = <Session>[];  // List to hold completed sessions
    // final profile = Provider.of<Profile>(context);

    final String hd = 'COMPLETED';  // Header text

    final _formKey = GlobalKey<FormState>();
    final TextEditingController _feedbackController = TextEditingController();

    // If session data is null, return loading widget
    session.forEach((element) {
      if (element.status == 'complete') {
        sessionData.add(element);  // Collect completed sessions
      }
    });
  
    // Check if session data has completed sessions
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
            padding: EdgeInsets.only(top: 20, left: 10, right: 8),
            decoration: BoxDecoration(
              color: yl,
              borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
            ),
            child: ListView.builder(
              itemCount: sessionData.length,
              itemBuilder: (context, index) {
                return StreamBuilder(
                  stream: ProfileDataService(uid: sessionData[index].tutorId).profile,  // Stream for profile data
                  builder: (BuildContext context, AsyncSnapshot<Profile> snapshot) {
                    if (snapshot.hasData) {
                      return Container(
                        decoration: BoxDecoration(
                          color: wy,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        margin: EdgeInsets.all(20),
                        child: Column(
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
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
                                  SizedBox(height: 25),
                                  // Center(
                                  //   child: ElevatedButton(
                                  //     style: ElevatedButton.styleFrom(
                                  //       backgroundColor: Colors.blue[300],
                                  //     ),
                                  //     child: Text('Evaluate'),
                                  //     onPressed: sessionData[index].mark
                                  //         ? () {
                                  //             showDialog(
                                  //               context: context,
                                  //               builder: (BuildContext context) {
                                  //                 return Evaluate(
                                  //                   sessid: sessionData[index].id,
                                  //                   tuteeid: sessionData[index].tutorId,
                                  //                   sesssub: sessionData[index].subject,
                                  //                   formKey: _formKey,
                                  //                   fdController: _feedbackController,
                                  //                 );
                                  //               },
                                  //             );
                                  //           }
                                  //         : null,
                                  //   ),
                                  // ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Loading();  // Return loading widget if profile data is not available yet
                    }
                  },
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy);  // Show if no completed sessions
    }
  }
}

class Evaluate extends StatelessWidget {
  const Evaluate({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController fdController,
    required String tuteeid,
    required String sesssub,
    required String sessid,
  })  : _formKey = formKey,
        _tuteeid = tuteeid,
        _sesssub = sesssub,
        _sessid = sessid,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final String _sesssub, _tuteeid, _sessid;

  @override
  Widget build(BuildContext context) {
    double _rate = 0;

    return AlertDialog(
      content: Stack(
        children: <Widget>[
          Positioned(
            right: -40.0,
            top: -40.0,
            child: InkResponse(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: CircleAvatar(
                child: Icon(Icons.close, color: yl),
                backgroundColor: bl,
              ),
            ),
          ),
          Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Center(
                  child: Text(
                    'From the scale of 1-5, please rate the tutee knowledge and understanding for the tutored subject',
                    style: TextStyle(fontSize: 19),
                  ),
                ),
                SizedBox(height: 30),
                RatingBar.builder(
                  initialRating: _rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rate = rating;
                  },
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: bl),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                    onPressed: () async {
                      // Update evaluation data
                      await EvaluateDataService(uid: _tuteeid)
                          .getEvData(_sesssub, _rate);

                      // Mark the session as evaluated
                      await TutorDataService(id: _sessid).updateMarkData(_sessid);

                      Navigator.of(context).pop();  // Close dialog after submission
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
