// ignore_for_file: prefer_const_constructors

import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/session.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter_application_1/model/global.dart';

class NoSession extends StatelessWidget {
  const NoSession({
    Key? key,
    required this.hd,
    required this.yl,
    required this.bl,
    required this.wy,
  }) : super(key: key);

  final String hd;
  final Color yl;
  final Color bl;
  final Color wy;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Header(hd: hd, bl: bl, wy: wy),
      ),
      body: Container(
        color: wy,
        child: Container(
            padding: EdgeInsets.only(
              top: 20,
              left: 10,
              right: 8,
            ),
            decoration: BoxDecoration(
              color: yl,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(40),
              ),
            ),
            child: Center(
                heightFactor: 10.0,
                child: Text('No ' + hd.toLowerCase() + ' session'))),
      ),
    );
  }
}

class ProfileDisplay extends StatelessWidget {
  const ProfileDisplay({
    Key? key,
    required this.snapshot,
    required this.sessionData,
    required this.index,
  }) : super(key: key);

  final List<Session> sessionData;
  final AsyncSnapshot<Profile> snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    assert(snapshot.data != null, 'Profile data cannot be null'); // This will throw an error if data is null

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipOval(
            child: SizedBox(
              height: 85.0,
              width: 85.0,
              child: Image.network(
                snapshot.data!.image, // Use ! to assert it is not null
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            width: 180,
            padding: EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(snapshot.data!.fullName, style: nm), // Use ! to assert it is not null
                Text(sessionData[index].date + ' ' + sessionData[index].day),
                Text(
                  sessionData[index].slot.toString(),
                ),
                Text(sessionData[index].venue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
