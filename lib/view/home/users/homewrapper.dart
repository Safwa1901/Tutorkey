import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter_application_1/view/home/users/tutee/sessionwrapperTutee.dart';
import 'package:flutter_application_1/view/home/users/tutor/sessionwrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Get the Profile object from the Provider
    final profile = Provider.of<Profile?>(context);

    // Check if the profile is null
    if (profile == null) {
      print("profile is missing");
      return Loading();
    } else {
      // Return the correct session wrapper based on the profile type
      return profile.type ? SessionWrapperTutor() : SessionWrapperTutee();
    }
  }
}


// class HomeWrapper extends StatefulWidget {
//   @override
//   _HomeWrapperState createState() => _HomeWrapperState();
// }

// class _HomeWrapperState extends State<HomeWrapper> {
//   @override
//   Widget build(BuildContext context) {
//     final profile = Provider.of<Profile>(context);
//     print(profile.type);

//     if (profile.type == null) {
//       return Center(
//         child: CircularProgressIndicator(
//           backgroundColor: Colors.white,
//         ),
//       );
//     } else {
//       return MaterialApp(
//         home: profile.type ? SessionWrapperTutor() : SessionWrapperTutee(),
//       );
//     }
//   }
// }
