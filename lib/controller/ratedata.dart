import 'package:flutter_application_1/model/rate.dart'; // Update the import path as necessary
import 'package:cloud_firestore/cloud_firestore.dart';

class RateDataService {
  final String uid;

  RateDataService({required this.uid});

  // Rate collection reference
  final CollectionReference rateCollection = FirebaseFirestore.instance.collection('rating');

  Rate _rateFromSnapshot(DocumentSnapshot snapshot) {
    final data = snapshot.data() as Map<String, dynamic>; // Safe casting
    return Rate(
      theRate: (data['rate'] ?? 0.0) as double, // Default to 0.0 if absent
    );
  }

  Future<void> createRateData() async {
    return await rateCollection.doc(uid).set({
      'rate': 0.0,
    });
  }

  // Update tutee rate
  Future<void> updateRatingData(double oldRate, double newRate) async {
    double theRate = calculateRating(oldRate, newRate); // Ensure calculateRating is defined

    return await rateCollection.doc(uid).update({
      'rate': theRate,
    });
  }

  Stream<Rate> get rating {
    return rateCollection.doc(uid).snapshots().map(_rateFromSnapshot);
  }

  Future<void> getRateData(double nRate) async {
    DocumentSnapshot rateSnapshot = await rateCollection.doc(uid).get();
    double oldRate = (rateSnapshot.data() as Map<String, dynamic>)['rate'] ?? 0.0; // Default to 0.0 if absent
    print(rateSnapshot.data().toString());

    await updateRatingData(oldRate, nRate);
  }
}
