import 'package:flutter_application_1/controller/evaluatedata.dart';
import 'package:flutter_application_1/controller/feeddata.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/ratedata.dart';
import 'package:flutter_application_1/controller/scheduledata.dart';
//import 'package:flutter_application_1/controller/subjectdata.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Create user object based on User
  UserModel? _userFromFirebaseUser(User? user) {
    return user != null ? UserModel(uid: user.uid) : null;
  }

  // Auth user change stream
  Stream<UserModel?> get user {
    return _auth.authStateChanges().map(_userFromFirebaseUser);
  }

  // Sign in anonymously
  Future<UserModel?> signInAnon() async {
    try {
      UserCredential result = await _auth.signInAnonymously();
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null; // return null if there's an error
    }
  }

  // Sign in with email & password
  Future<UserModel?> signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;
      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null; // return null if there's an error
    }
  }

  // Register with email & password
  Future<UserModel?> registerWithEmailAndPassword(bool usertype, String name, String phone,
      String email, String password) async {
    try {
      // Create user with email and password
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = result.user;

      // Create user profile data
      await ProfileDataService(uid: user!.uid).createProfileData(usertype, name, phone);

      // Create tutor schedule or evaluation data
      if (usertype) {
        await ScheduleDataService(uid: user.uid).createScheduleData();
        await FeedDataService(uid: user.uid).createFeedbackData();
        await RateDataService(uid: user.uid).createRateData();
      } else {
        await EvaluateDataService(uid: user.uid).createEvaluationData();
      }

      return _userFromFirebaseUser(user);
    } catch (e) {
      print(e.toString());
      return null; // return null if there's an error
    }
  }

  // Sign out
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print(e.toString());
    }
  }
}
