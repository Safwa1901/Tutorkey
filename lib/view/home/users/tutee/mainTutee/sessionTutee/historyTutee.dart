// ignore_for_file: prefer_const_constructors, prefer_const_declarations, sort_child_properties_last

// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_application_1/controller/feeddata.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/ratedata.dart';
import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/rate.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter_application_1/view/home/loading.dart';
// import 'package:flutter_application_1/view/home/users/tutee/mainTutee/rateTutee/rateSession.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/widgetSessionTutee.dart';

class ProfileDisplay extends StatelessWidget {
  final Profile profileData;
  final List<Session> sessionData;
  final int index;

  ProfileDisplay({
    required this.profileData,
    required this.sessionData,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('Tutor: ${profileData.fullName}'),
        Text('Subject: ${sessionData[index].subject}'),
        // Add other display fields as necessary
      ],
    );
  }
}

class HistoryTutee extends StatefulWidget {
  final Rate? rate;
  HistoryTutee({this.rate});
  @override
  _HistoryTuteeState createState() => _HistoryTuteeState();
}

class _HistoryTuteeState extends State<HistoryTutee> {
  @override
  Widget build(BuildContext context) {
    final session = Provider.of<List<Session>?>(context);
    final profile = Provider.of<Profile?>(context);

    final List<Session> sessionData = [];
    final String hd = 'COMPLETED';
    // final _formKey = GlobalKey<FormState>();
    // final TextEditingController _feedbackController = TextEditingController();

    if (session == null || profile == null) {
      return Loading(); // Show loading indicator until session and profile are available
    } else {
      session.forEach((element) {
        if (element.status == 'complete') {
          sessionData.add(element);
        }
      });
    }
    

    if (sessionData.isNotEmpty) {
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
              itemCount: sessionData.length,
              itemBuilder: (context, i) { // Use 'i' for the index
                return StreamBuilder<Profile?>(
                  stream: ProfileDataService(uid: sessionData[i].tutorId).profile,
                  builder: (BuildContext context, AsyncSnapshot<Profile?> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator(); // Show a loading indicator
                    } else if (snapshot.hasData && snapshot.data != null) {
                      final profileData = snapshot.data!; // Unwrap Profile safely using '!'
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
                              padding: EdgeInsets.fromLTRB(30, 20, 30, 30),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceAround,
                                children: <Widget>[
                                  Text(
                                    sessionData[i].subject.toUpperCase(),
                                    style: sb,
                                  ),
                                  SizedBox(height: 20),
                                  ProfileDisplay(
                                    profileData: profileData, // Pass profileData directly
                                    sessionData: sessionData,
                                    index: i, // Pass 'i' as index
                                  ),
                                  SizedBox(height: 25),
                                  // Add other UI components here as needed
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Center(
                        child: Text("Profile not available"),
                      );
                    }
                  },
                );
              },
            ),
          ),
        ),
      );
    } else {
      return NoSession(hd: hd, yl: yl, bl: bl, wy: wy); // Display message if no sessions available
    }
  }
}

class FeedbackDialog extends StatelessWidget {
  const FeedbackDialog({
    Key? key,
    required GlobalKey<FormState> formKey,
    required TextEditingController fdController,
    required String uid,
    required String sessid,
    required String sesssub,
    required String teename,
  })  : _formKey = formKey,
        _fdController = fdController,
        _uid = uid,
        _sessid = sessid,
        _sesssub = sesssub,
        _teename = teename,
        super(key: key);

  final GlobalKey<FormState> _formKey;
  final TextEditingController _fdController;
  final String _uid, _sesssub, _sessid, _teename;

  @override
  Widget build(BuildContext context) {
    double _rate = 0;

    return AlertDialog(
      content: Stack(
        clipBehavior: Clip.none, // Removed deprecated overflow
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
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: TextFormField(
                    maxLines: 3,
                    decoration:
                        InputDecoration(labelText: "Enter your feedback"),
                    controller: _fdController,
                  ),
                ),
                SizedBox(height: 30),
                RatingBar.builder(
                  initialRating: _rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    _rate = rating;
                    print(rating);
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bl,
                    ),
                    child: Text(
                      "Submit",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.5,
                      ),
                    ),
                    onPressed: () async {
                      await FeedDataService(uid: _uid).addFeedbackData(
                          _fdController.text, _sesssub, _teename, _rate);
                      await TutorDataService(id: _sessid).updateRateData(_sessid); // Correct argument name here
                      await RateDataService(uid: _uid).getRateData(_rate);
                      Navigator.of(context).pop();
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
