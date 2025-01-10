//import 'package:flutter_application_1/controller/ratedata.dart'; // Update the import path as necessary
//import 'package:flutter_application_1/model/rate.dart';         // Update the import path as necessary
import 'package:flutter_application_1/model/feedback.dart';     // Update the import path as necessary
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';

class FeedDataService {
  final String uid;

  FeedDataService({required this.uid});

  // Feed collection reference
  final CollectionReference feedCollection = FirebaseFirestore.instance.collection('feedback');

  FeedList _feedFromSnapshot(DocumentSnapshot snapshot) {
  // Extract the feed data from the snapshot and convert it to a List<Feed>
  List<Feed> feeds = (snapshot['feed'] as List<dynamic>? ?? [])
      .map((item) => Feed.fromMap(item as Map<String, dynamic>))
      .toList();

  // Return the FeedList with the extracted feeds
  return FeedList(fdb: feeds);
}

  // Get feedback stream
  Stream<FeedList> get feedback {
    return feedCollection.doc(uid).snapshots().map(_feedFromSnapshot);
  }

  Future<void> createFeedbackData() async {
    return await feedCollection.doc(uid).set({
      "feed": [],
    });
  }

  Future<void> addFeedbackData(String fd, String sb, String tn, double rt) async {
    return await feedCollection.doc(uid).update({
      "feed": FieldValue.arrayUnion([
        {
          "fd": fd,
          "sb": sb,
          "tn": tn,
          "rt": rt,
        },
      ])
    });
  }
}
