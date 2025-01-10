import 'package:flutter_application_1/model/session.dart'; 
import 'package:cloud_firestore/cloud_firestore.dart';

class TutorDataService {
  final String id;

  // Session collection reference
  final CollectionReference sessionCollection =
      FirebaseFirestore.instance.collection('session');

  TutorDataService({required this.id});

  // Tutor session add
  Future<void> addTutorSession(String tutorid, String tuteeid, String subject,
      String date, String day, int slot, String venue) async {
    await sessionCollection.add({
      'tutorid': tutorid,
      'tuteeid': tuteeid,
      'subject': subject,
      'date': date,
      'day': day,
      'slot': slot,
      'venue': venue,
      'status': 'pending',
      'rate': true,
      'mark': true,
    });
  }

  // Convert query snapshot to session list
  List<Session> _sessionFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      final data = doc.data() as Map<String, dynamic>?; // Ensure type safety

      return Session(
        id: doc.id,
        tutorId: data?['tutorid'] ?? '', // Use default if null
        tutorName: data?['tutornm'] ?? '', // Use default if null
        tuteeId: data?['tuteeid'] ?? '', // Use default if null
        tuteeName: data?['tuteenm'] ?? '', // Use default if null
        subject: data?['subject'] ?? '', // Use default if null
        date: data?['date'] ?? '', // Use default if null
        day: data?['day'] ?? '', // Use default if null
        venue: data?['venue'] ?? '', // Use default if null
        slot: data?['slot'] ?? 0, // Use default if null
        status: data?['status'] ?? '', // Use default if null
        rate: data?['rate'] ?? false, // Use default if null
        mark: data?['mark'] ?? false, // Use default if null
      );
    }).toList();
  }

  // Get session stream for tutor
  Stream<List<Session>> get sessiontutor {
    return sessionCollection
        .where('tutorid', isEqualTo: id)
        .snapshots()
        .map(_sessionFromSnapshot);
  }

  // Update rate data
  Future<void> updateRateData(String sessid) async {
    return await sessionCollection.doc(sessid).update({
      'rate': false,
    });
  }

  // Update mark data
  Future<void> updateMarkData(String sessid) async {
    return await sessionCollection.doc(sessid).update({
      'mark': false,
    });
  }

  // Update tutor session
  Future<void> updateTutorSessionData(String sessid, String status) async {
    return await sessionCollection.doc(sessid).update({
      'status': status,
    });
  }

  // Update tutor session rate
  Future<void> feedTutorSessionData(String sessid, bool rate) async {
    return await sessionCollection.doc(sessid).update({
      'rate': rate,
    });
  }

  // Get session stream for tutee
  Stream<List<Session>> get sessiontutee {
    return sessionCollection
        .where('tuteeid', isEqualTo: id)
        .snapshots()
        .map(_sessionFromSnapshot);
  }
}
