import 'package:flutter_application_1/model/schedule.dart'; // Update to match your project structure
import 'package:cloud_firestore/cloud_firestore.dart';

class ScheduleDataService {
  final String uid;

  ScheduleDataService({required this.uid}); // Use 'required' for better null safety

  // Schedule document reference
  final CollectionReference scheduleCollection =
      FirebaseFirestore.instance.collection('profile'); // Updated to use FirebaseFirestore

  // Update schedule data
  Future<void> updateScheduleData(String day, String slot, bool event) async {
    return await scheduleCollection
        .doc(uid) // Updated from 'document' to 'doc'
        .collection('schedule')
        .doc(day) // Updated from 'document' to 'doc'
        .update({
      slot: event,
    });
  }

  // Create schedule collection
  Future<void> createScheduleData() async {
    bool slot = false;
    List<String> days = ['mon', 'tue', 'wed', 'thu', 'fri', 'sat', 'sun'];

    for (int i = 0; i < days.length; i++) {
      await scheduleCollection
          .doc(uid) // Updated from 'document' to 'doc'
          .collection('schedule')
          .doc(days[i]) // Updated from 'document' to 'doc'
          .set({
        'order': i + 1,
        'slot1': slot,
        'slot2': slot,
        'slot3': slot,
      });
    }
  }

  // Change schedule list stream to object list
  List<Schedule> _scheduleFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      // Cast data to Map<String, dynamic>
      final data = doc.data() as Map<String, dynamic>?; // Cast to nullable map
      return Schedule(
        id: doc.id, // Updated from 'documentID' to 'id'
        slot1: data?['slot1'] ?? false, // Added null check and default value
        slot2: data?['slot2'] ?? false, // Added null check and default value
        slot3: data?['slot3'] ?? false, // Added null check and default value
      );
    }).toList();
  }

  // Get schedule data list
  Stream<List<Schedule>> get schedule {
    return scheduleCollection
        .doc(uid) // Updated from 'document' to 'doc'
        .collection('schedule')
        .orderBy('order')
        .snapshots()
        .map(_scheduleFromSnapshot);
  }
}
