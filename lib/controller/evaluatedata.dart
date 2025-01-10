import 'package:flutter_application_1/model/evaluate.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EvaluateDataService {
  final String uid;

  EvaluateDataService({required this.uid});

  // Firestore collection reference
  final CollectionReference evCollection = FirebaseFirestore.instance.collection('evaluation');

  // Helper method to extract evaluations from Firestore document
  List<Evaluate> extractEvaluation(List<dynamic> evalData) {
    return evalData.map((e) => Evaluate(sb: e['sb'], mk: e['mk'])).toList();
  }

  // Convert Firestore snapshot into EvaluateList
  List<Evaluate> _evFromSnapshot(DocumentSnapshot snapshot) {
    // Extract the evaluations from the snapshot
    List<dynamic> evalData = snapshot['evaluate'] ?? [];

    // Convert the extracted data to a List<Evaluate>
    return extractEvaluation(evalData);
  }

  // Stream to listen to evaluations from Firestore
  Stream<List<Evaluate>> get evaluation {
    return evCollection.doc(uid).snapshots().map(_evFromSnapshot);
  }

  // Create evaluation document in Firestore
  Future<void> createEvaluationData() async {
    return await evCollection.doc(uid).set({
      "evaluate": [],
    });
  }

  // Update subject evaluation
  Future<void> updateEvaluationData(String sb, double mk) async {
    return await evCollection.doc(uid).update({
      "evaluate": FieldValue.arrayUnion([
        {
          "sb": sb,
          "mk": mk,
        },
      ])
    });
  }

  // Delete subject from evaluation array
  Future<void> deleteEvaluationData(String sb, double mk) async {
    return await evCollection.doc(uid).update({
      'evaluate': FieldValue.arrayRemove([
        {'sb': sb, 'mk': mk}
      ]),
    });
  }

  // Logic to get, update, and calculate evaluation data
  Future<void> getEvData(String sEv, double nEv) async {
    // Snapshot evaluation
    DocumentSnapshot evSnapshot = await evCollection.doc(uid).get();
    var evMap = evSnapshot['evaluate'] as List<dynamic>;
    List<Evaluate> dataEv = extractEvaluation(evMap);
    double oldEv = 0.0;

    // Find the old evaluation
    for (var e in dataEv) {
      if (e.sb == sEv) {
        oldEv = e.mk;
        break;
      }
    }

    double pEv = nEv / 5 * 100;
    double newEv = (oldEv + pEv) / 200;
    double percentEv = newEv;

    // Remove the old one and update with the new value
    await deleteEvaluationData(sEv, oldEv);
    await updateEvaluationData(sEv, percentEv);
  }

  // Delete a subject evaluation
  Future<void> deleteEvaluationSubject(String sEv) async {
    DocumentSnapshot evSnapshot = await evCollection.doc(uid).get();
    var evMap = evSnapshot['evaluate'] as List<dynamic>;
    List<Evaluate> dataEv = extractEvaluation(evMap);

    // Find and remove the old evaluation
    double oldEv = 0.0;
    for (var e in dataEv) {
      if (e.sb == sEv) {
        oldEv = e.mk;
        break;
      }
    }

    await deleteEvaluationData(sEv, oldEv);
  }
}
