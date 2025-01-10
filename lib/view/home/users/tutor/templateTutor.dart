import 'package:flutter/material.dart';
//import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter_application_1/controller/auth.dart';
import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter_application_1/view/home/users/tutor/dashboardTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/sessionTutor/historyTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/homeTutor/homeTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/manageTutor/profileTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/manageTutor/subjectTutor.dart';
import 'package:flutter_application_1/view/home/users/tutor/mainTutor/scheduleTutor/scheduleTutor.dart';

class TemplateTutor extends StatefulWidget {
  @override
  _TemplateTutorState createState() => _TemplateTutorState();
}

class _TemplateTutorState extends State<TemplateTutor> {
  final AuthService _auth = AuthService();
  int _selectedIndex = 0;

  // List of widget options for different tabs
  final List<Widget> _widgetOptions = <Widget>[
    HomeTutor(),
    ScheduleTutor(),
    DashboardTutor(),
    HistoryTutor(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index; // Update the selected index
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue[200],
              ),
              child: Text(
                'Drawer Header',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              title: Text('Manage Profile'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ProfileTutor()),
                );
              },
            ),
            ListTile(
              title: Text('Manage Tutoring'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => SubjectTutor()),
                );
              },
            ),
            ListTile(
              title: Text('Test Loading'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Loading()),
                );
              },
            ),
            Container(
              margin: EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 10.0),
              height: 50.0,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                onPressed: () async {
                  await _auth.signOut(); // Sign out when pressed
                },
                child: Text(
                  'Logout',
                  style: TextStyle(color: Colors.black, fontSize: 15.0),
                ),
              ),
            ),
          ],
        ),
      ),
      body: _widgetOptions.elementAt(_selectedIndex), // Display selected widget

      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Colors.blue[100],
        items: [
          TabItem(
            icon: Image.asset('assets/profile.png', width: 35.0),
            title: "Profile",
          ),
          TabItem(
            icon: Image.asset('assets/calendar.png', width: 35.0),
            title: "Schedule",
          ),
          TabItem(
            icon: Image.asset('assets/progress.png', width: 35.0),
            title: "Active",
          ),
          TabItem(
            icon: Image.asset('assets/history.png', width: 35.0),
            title: "Past",
          ),
        ],
        onTap: _onItemTapped,
        initialActiveIndex: _selectedIndex, // Set the initial active index
      ),
    );
  }
}


      // bottomNavigationBar: BottomNavigationBar(
      //   //type: BottomNavigationBarType.fixed,
      //   backgroundColor: Colors.blue,
      //   currentIndex: _selectedIndex,
      //   selectedItemColor: Colors.black,
      //   onTap: _onItemTapped,
      //   items: <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.person),
      //       title: Text('Home'),
      //       backgroundColor: Colors.blue,
      //     ),
      //     BottomNavigationBarItem(
      //       //icon: Image.asset('assets/search.png'),
      //       icon: Icon(Entypo.calendar),
      //       title: Text('Business'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(MaterialIcons.assignment),
      //       title: Text('School'),
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(MaterialIcons.assignment_late),
      //       title: Text('School'),
      //     ),
      //   ],
      // ),
