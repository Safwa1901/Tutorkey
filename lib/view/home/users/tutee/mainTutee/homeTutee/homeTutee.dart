// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/manageTutee/profileTutee.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class HomeTutee extends StatelessWidget {
  final TextStyle userN = TextStyle(fontSize: 30.0);

  final Color yl = Color(0xffF0C742);
  final Color wy = Colors.white;
  final Color bl = Colors.black;

  final TextStyle info = TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  final TextStyle title = TextStyle(
    fontSize: 15,
    color: Colors.black54,
  );

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    // final double height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: yl,
      body: ListView(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                child: Image.network(
                  profile.image,
                  fit: BoxFit.fitHeight,
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
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: yl,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(35.0),
                topLeft: Radius.circular(35.0),
              ),
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
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
                  title: Text('Exam', style: title),
                  subtitle: Text(profile.extraInfo, style: info),
                ),
                SizedBox(height: 30),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      backgroundColor: Colors.black,
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ProfileTutee()),
                      );
                    },
                    child: Text(
                      'Manage',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 15.0,
                        letterSpacing: 1.2,
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
