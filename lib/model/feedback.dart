//import 'package:flutter/material.dart';

// Feed class definition
class Feed {
  final String feed;
  final String subject;
  final String teename;
  final double rate;

  // Use required keyword for null safety
  Feed({
    required this.feed,
    required this.subject,
    required this.teename,
    required this.rate,
  });

  // Convert the Feed object to a map for Firestore
  Map<String, dynamic> toMap() => {
        'fd': feed,
        'sb': subject,
        'tn': teename,
        'rt': rate, // Include rate in the map if needed
      };

  // Create a Feed object from a map
  Feed.fromMap(Map<String, dynamic> map)
      : feed = map['fd'].toString(),
        subject = map['sb'].toString(),
        teename = map['tn'].toString(),
        rate = double.parse(map['rt'].toString());
}

// Function to extract Feed objects from a List of dynamic
List<Feed> extractFeed(List<dynamic> feedbackMap) {
  return feedbackMap.map<Feed>((item) => Feed.fromMap(item)).toList();
}

// FeedList class definition
class FeedList {
  List<Feed> fdb; // Change type to List<Feed>

  // Use required keyword for null safety and initialize the list
  FeedList({
    required this.fdb,
  });

  // Convert FeedList to a map for Firestore
  Map<String, dynamic> toMap() => {
        "fdb": this.fdb.map((feed) => feed.toMap()).toList(), // Convert each Feed to map
      };

  // Uncomment this constructor if you want to initialize from a map
  FeedList.fromMap(Map<dynamic, dynamic> map)
      : fdb = (map['fdb'] as List)
            .map((item) => Feed.fromMap(item as Map<String, dynamic>))
            .toList();
}
