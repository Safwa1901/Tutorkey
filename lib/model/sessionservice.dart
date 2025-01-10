import 'package:cloud_firestore/cloud_firestore.dart';

class SessionService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addTutorSession(String tutorId, String userId, String subject, String date, String day, int? slot, String venue) async {
    // Replace 'sessions' with your actual Firestore collection name
    await _db.collection('sessions').add({
      'tutorId': tutorId,
      'userId': userId,
      'subject': subject,
      'date': date,
      'day': day,
      'slot': slot,
      'venue': venue,
    });
  }
}
