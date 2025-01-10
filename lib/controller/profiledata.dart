import 'package:flutter_application_1/model/profile.dart'; // Update the import path as necessary
import 'package:cloud_firestore/cloud_firestore.dart';

class ProfileDataService {
  final String uid;

  ProfileDataService({required this.uid});

  // Profile collection reference
  final CollectionReference profileCollection = FirebaseFirestore.instance.collection('profile');

  // Change profile stream to object
  Profile _profileFromSnapshot(DocumentSnapshot snapshot) {
    print("Profile exists and data found: $snapshot");
    if (snapshot.exists && snapshot.data() != null) {
      
    final data = snapshot.data() as Map<String, dynamic>; // Ensure safe casting
    List<String> subjects = List<String>.from(data['subject'] ?? []);
    print("Profile exists and data found: $data");
    return Profile(
      uid: uid,
      type: data['userType'] ?? '',
      fullName: data['fullName'] ?? '',
      phoneNumber: data['phoneNumber'] ?? '',
      bio: data['bio'] ?? '',
      address: data['address'] ?? '',
      education: data['education'] ?? '',
      extraInfo: data['extraInfo'] ?? '',
      image: data['image'] ?? '',
      exam: data['exam'] ?? '',
      // subject: data['subject'] ?? [],
     subject: subjects, // Use the converted list
      price: (data['price'] ?? 0.0) as double,
    );
    
  }else{
    print("Profile document does not exist for uid: $uid");
    throw Exception("Profile document does not exist for uid: $uid");
  }
  }
  // Get profile stream
  Stream<Profile> get profile {
   print("Listening to profile stream...");
    return profileCollection
        .doc(uid)
        .snapshots()
        // .map(_profileFromSnapshot);
        .map((snapshot) {
          if (snapshot == null) {
            print("Snapshot is null");
            throw Exception("Snapshot is null for uid: $uid");
          }
            // Print the entire snapshot data
            print("Snapshot data: ${snapshot.data()}");
            
            // Then map it to Profile
            return _profileFromSnapshot(snapshot);
        })
              .handleError((error) {
        print("Error fetching profile: $error");
      });       
  }

  // Create profile data
  String tee =
      'https://firebasestorage.googleapis.com/v0/b/cikguu-app.appspot.com/o/595271aabbdbfbc2d7bd5b85b7227540.png?alt=media&token=6e37ea89-3ffb-42e2-b15f-60095b125a26';
  String tor =
      'https://firebasestorage.googleapis.com/v0/b/cikguu-app.appspot.com/o/0f2a9a9dfdca0374082be57293ad9424.png?alt=media&token=12ab22b6-14e3-4230-9483-821197a67e67';
  
  Future<void> createProfileData(bool userType, String fullName, String phoneNumber) async {
    return await profileCollection.doc(uid).set({
      'userType': userType,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'bio': 'Please fill',
      'address': 'Please fill',
      'education': 'Please fill',
      'extraInfo': 'Please fill',
      'image': userType ? tor : tee,
      'subject': [],
      'price': 0.0,
    });
  }

  // Update profile data
  Future<void> updateProfileData(String name, String bio, String phone,
      String address, String education, String extra) async {
    return await profileCollection.doc(uid).update({
      'fullName': name,
      'phoneNumber': phone,
      'bio': bio,
      'address': address,
      'education': education,
      'extraInfo': extra,
    });
  }

  // Update price rate data
  Future<void> updatePriceData(double price) async {
    return await profileCollection.doc(uid).update({
      'price': price,
    });
  }

  // Update subjects array
  Future<void> updateSubject(String subject) async {
    return await profileCollection.doc(uid).update({
      'subject': FieldValue.arrayUnion([subject]),
    });
  }

  // Delete subject from array
  Future<void> deleteSubject(String subject) async {
    return await profileCollection.doc(uid).update({
      'subject': FieldValue.arrayRemove([subject]),
    });
  }

  // Update teaching info
  Future<void> updateTutoringData(String subject) async {
    return await profileCollection.doc(uid).update({'subject': subject});
  }

  // Update image data
  Future<void> updateProfileImageData(String url) async {
    return await profileCollection.doc(uid).update({
      'image': url,
    });
  }
}
