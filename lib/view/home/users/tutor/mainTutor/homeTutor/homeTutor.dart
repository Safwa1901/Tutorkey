// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/manageTutee/profileTutee.dart';
import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:provider/provider.dart';

class HomeTutor extends StatelessWidget {
  final TextStyle userN = const TextStyle(fontSize: 30.0);

  final Color yl = const Color(0xffF0C742);
  final Color wy = Colors.white;
  final Color bl = Colors.black;

  final TextStyle info = const TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  final TextStyle title = const TextStyle(
    fontSize: 15,
    color: Colors.black54,
    height: 1.5,
  );

  // Constructor with a named parameter for key
  const HomeTutor({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile?>(context); // Use nullable Profile

    // Check if profile is null
    if (profile == null) {
      return const Center(child: CircularProgressIndicator()); // Show loading indicator or error
    }

    return Scaffold(
      backgroundColor: yl,
      body: ListView(
        children: <Widget>[
          Stack(children: <Widget>[
            Container(
              width: double.infinity,
              child: Image.network(
                profile.image,
                fit: BoxFit.fitHeight,
                errorBuilder: (context, error, stackTrace) => const Center(child: Icon(Icons.error)), // Handle image loading error
              ),
            ),
            Positioned(
              child: IconButton(
                icon: Icon(
                  Feather.chevron_left,
                  color: wy,
                  size: 35,
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
          ]),
          Container(
            decoration: BoxDecoration(
              color: yl,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35.0),
                topLeft: Radius.circular(35.0),
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 25.0),
            transform: Matrix4.translationValues(0.0, -50.0, 0.0),
            child: Column(
              children: <Widget>[
                ListTile(
                  title: Text('Name', style: title),
                  subtitle: Text(profile.fullName, style: info),
                ),
                ListTile(
                  title: Text('Phone Number', style: title),
                  subtitle: Text(profile.phoneNumber, style: info),
                ),
                ListTile(
                  title: Text('Bio', style: title),
                  subtitle: Text(profile.bio, style: info),
                ),
                ListTile(
                  title: Text('Address', style: title),
                  subtitle: Text(profile.address, style: info),
                ),
                ListTile(
                  title: Text('Education', style: title),
                  subtitle: Text(profile.education, style: info),
                ),
                ListTile(
                  title: Text('Experience', style: title),
                  subtitle: Text(profile.extraInfo, style: info),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton( // Use ElevatedButton instead of RaisedButton
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.black, // Set button color
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => ProfileTutee()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: const Text(
                        'Manage',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 15.0,
                          letterSpacing: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
