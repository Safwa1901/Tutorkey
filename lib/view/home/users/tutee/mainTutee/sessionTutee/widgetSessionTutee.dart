// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers

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
          padding: const EdgeInsets.only(
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
            child: Text('No ' + hd.toLowerCase() + ' session'),
          ),
        ),
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
    if (!snapshot.hasData || sessionData.isEmpty || index >= sessionData.length) {
      return const SizedBox.shrink(); // Return an empty widget if no data is available
    }

    final profile = snapshot.data!;
    final session = sessionData[index];

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          ClipOval(
            child: SizedBox(
              height: 85.0,
              width: 85.0,
              child: profile.image.isNotEmpty
                  ? Image.network(
                      profile.image,
                      fit: BoxFit.cover,
                    )
                  : const Placeholder(), // Placeholder in case of no image
            ),
          ),
          Container(
            width: 180,
            padding: const EdgeInsets.only(left: 25),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(profile.fullName, style: nm),
                Text('${session.date} ${session.day}'),
                Text(session.slot.toString()),
                Text(session.venue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
