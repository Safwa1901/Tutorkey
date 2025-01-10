// ignore_for_file: prefer_const_constructors, prefer_const_declarations

// import 'package:flutter_application_1/controller/ratedata.dart';
import 'package:flutter_application_1/model/feedback.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class FeedbackTutor extends StatefulWidget {
  @override
  _FeedbackTutorState createState() => _FeedbackTutorState();
}

class _FeedbackTutorState extends State<FeedbackTutor> {
  @override
  Widget build(BuildContext context) {
    final String hd = 'FEEDBACK';
    final profile = Provider.of<Profile>(context);
    final feedback = Provider.of<FeedList>(context);
if (!mounted) return Container();
    // Removed null check since feedback is assumed to be non-null in context
    var feedbackMap = feedback.fdb;  // Assumes fdb is defined
    List<Feed> feedData = extractFeed(feedbackMap);

    return StreamBuilder<DocumentSnapshot>(
      stream: FirebaseFirestore.instance
          .collection('rating')
          .doc(profile.uid)
          .snapshots(),
      builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Loading();
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return Center(child: Text('No ratings available.'));
        }

        Map<String, dynamic>? data = snapshot.data!.data() as Map<String, dynamic>?;
        var rate = data?['rate'] ?? 0.0;

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
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: Column(
              children: <Widget>[
                Center(child: Text('Current Rating by Tutee')),
                RatingBar.builder(
                  initialRating: rate,
                  minRating: 1,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: Colors.amber,
                  ),
                  onRatingUpdate: (rating) {
                    print('New Rating: $rating');
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: feedData.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: EdgeInsets.all(30),
                        margin: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: wy,
                          borderRadius: BorderRadius.all(Radius.circular(15)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text('Tutee Name: ${feedData[index].teename}'),
                            Text('Subject: ${feedData[index].subject}'),
                            // Text('Feedback: ${feedData[index].feed}'),
                            Text('Rating: ${feedData[index].rate.toString()}'),
                            RatingBar.builder(
                              initialRating: feedData[index].rate,
                              minRating: 1,
                              direction: Axis.horizontal,
                              allowHalfRating: true,
                              itemCount: 5,
                              itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                              itemBuilder: (context, _) => Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                              onRatingUpdate: (rating) {
                                print('Rating updated: $rating');
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
