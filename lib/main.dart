// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter_application_1/controller/auth.dart';
import 'package:flutter_application_1/model/user.dart';
// import 'package:flutter_application_1/view/authenticate/authenticate.dart';
import 'package:flutter_application_1/view/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  if(kIsWeb){
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyDjRABOhIaN39RTKjzG1svmHMnGbXO4sjE",
  authDomain: "fir-setup-4f76f.firebaseapp.com",
  projectId: "fir-setup-4f76f",
  storageBucket: "fir-setup-4f76f.appspot.com",
  messagingSenderId: "1078974238363",
  appId: "1:1078974238363:web:402a62ccfbe1ae46c6c03e",
  measurementId: "G-7K0WSW2JKR"));
  }
  else{
    await Firebase.initializeApp();
  }
  print("Firebase Initialized");
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<UserModel?>.value( 
      value: AuthService().user,  
      initialData: null,  
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Wrapper(),
        // home: Authenticate(),
      ),
    );
  }
}
