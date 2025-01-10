import 'package:cloud_firestore/cloud_firestore.dart';

class SubjectDataService {
  final String uid;

  SubjectDataService({required this.uid}); // Use 'required' for better null safety

  // SPM subject document reference
  final DocumentReference subjectDocumentSPM =
      FirebaseFirestore.instance.collection('subjects').doc('spm'); // Updated to use FirebaseFirestore

  final CollectionReference subjectDocument =
      FirebaseFirestore.instance.collection('profile'); // Updated to use FirebaseFirestore

  // Create subject teach data
  Future<void> createSubjectTeach() async {
    await subjectDocument.doc(uid).update({
      'subject': {
        'Malay': false,
        'English': false,
        'Science': false,
        'Mathematics': false,
        'History': false,
        'Moral Education': false,
        'Islamic Education': false,
        'Add. Mathematics': false,
        'Chemistry': false,
        'Biology': false,
        'Physics': false,
        'Economics': false,
      }
    });
  }

  // SPM subject add
  Future<void> addSubjectTutorSPM(
      String name, String img, String subject, double price) async {
    return await subjectDocumentSPM
        .collection(subject)
        .doc(uid) // Updated from 'document' to 'doc'
        .set({
      'name': name,
      'img': img,
      'price': price,
    });
  }

  // Remove SPM subject
  Future<void> deleteSubjectTutorSPM(String subject) async {
    return await subjectDocumentSPM
        .collection(subject)
        .doc(uid) // Updated from 'document' to 'doc'
        .delete();
  }
}
