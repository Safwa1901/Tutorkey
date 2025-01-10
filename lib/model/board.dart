// ignore_for_file: prefer_const_constructors, sort_child_properties_last, prefer_const_literals_to_create_immutables

import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/controller/profiledata.dart';
import 'package:flutter_application_1/controller/scheduledata.dart';
//import 'package:flutter_application_1/controller/tutordata.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/schedule.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/user.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:timeline_tile/timeline_tile.dart';
import 'package:flutter_application_1/model/sessionservice.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class BrowseDetails extends StatefulWidget {
  final String idTutor;
  final String subject;

  const BrowseDetails({Key? key, required this.idTutor, required this.subject}) : super(key: key);

  @override
  _BrowseDetailsState createState() => _BrowseDetailsState();
}

class _BrowseDetailsState extends State<BrowseDetails> with TickerProviderStateMixin {
  TabController? _tabController;

  final TextStyle info = const TextStyle(
    fontSize: 18,
    color: Colors.black,
  );

  final TextStyle title = const TextStyle(
    fontSize: 15,
    color: Colors.black54,
    height: 1.5,
  );
  String day = DateFormat('EEEE').format(DateTime.now()).toLowerCase();
  String sb = ''; // Current day in lowercase
  String dt = ''; // Declare dt for formatted date
  String dy = ''; 
  int? sl; 
  String vn = ''; 
  late SessionService _session; 


  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }
  
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _bookDate;  // Add this line
  
  // // Other member variables
  // String sb = '';
  // DateTime? _bookDate;
  // int? sl;
  // String vn = '';

  @override
Widget build(BuildContext context) {
  final user = Provider.of<UserModel>(context);
  return Scaffold(
    appBar: PreferredSize(
      preferredSize: const Size.fromHeight(200.0),
      child: AppBar(
        leading: IconButton(
          icon: Icon(
            Feather.chevron_left,
            color: bl,
            size: 35,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: Colors.greenAccent,
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'PROFILE'),
            Tab(text: 'SCHEDULE'),
            Tab(text: 'BOOK'),
          ],
          indicatorColor: Colors.black,
        ),
        flexibleSpace: Container(),
      ),
    ),
    body: TabBarView(
      controller: _tabController,
      children: <Widget>[
        // Profile Tab
        StreamBuilder<Profile>(
          stream: ProfileDataService(uid: widget.idTutor).profile,
          builder: (BuildContext context, AsyncSnapshot<Profile?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            if (!snapshot.hasData || snapshot.data == null) {
              return Center(child: Text('No profile data available.'));
            }

            return Container(
              color: yl,
              child: ListView(
                children: <Widget>[
                  SizedBox(
                    width: double.infinity,
                    child: Image.network(
                      snapshot.data!.image,
                      fit: BoxFit.contain,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        _buildProfileListTile('Name', snapshot.data!.fullName),
                        _buildProfileListTile('Phone Number', snapshot.data!.phoneNumber),
                        _buildProfileListTile('Bio', snapshot.data!.bio),
                        _buildProfileListTile('Address', snapshot.data!.address),
                        _buildProfileListTile('Education', snapshot.data!.education),
                        _buildProfileListTile('Experience', snapshot.data!.extraInfo),
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        // Schedule Tab
        Container(
          color: yl,
          padding: EdgeInsets.only(top: 10),
          child: StreamBuilder<List<Schedule>>(
            stream: ScheduleDataService(uid: widget.idTutor).schedule,
            builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }

              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return Center(child: Text('No schedule data available.'));
              }

              List<Schedule> scheduleData = snapshot.data!;
              return ListView.builder(
                itemCount: scheduleData.length,
                itemBuilder: (context, index) {
                  String dayName = _getDayName(scheduleData[index].id);
                  return TimelineTile(
                    beforeLineStyle: LineStyle(color: bl, thickness: 3),
                    afterLineStyle: LineStyle(color: bl, thickness: 3),
                    lineXY: 0,
                    indicatorStyle: IndicatorStyle(
                      color: scheduleData[index].id == day.toLowerCase() ? wy : bl,
                      padding: EdgeInsets.symmetric(horizontal: 15),
                      width: 13,
                      indicatorXY: 0.1,
                    ),
                    alignment: TimelineAlign.start,
                    endChild: Container(
                      margin: EdgeInsets.only(bottom: 20),
                      color: yl,
                      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 17),
                      decoration:BoxDecoration(
                      color: scheduleData[index].id == day.toLowerCase() ? wy : yl),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(dayName, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                          SizedBox(height: 10),
                          _buildSlotWidget('Slot 1', '(8am-10am)', scheduleData[index].slot1),
                          _buildSlotWidget('Slot 2', '(12pm-2pm)', scheduleData[index].slot2),
                          _buildSlotWidget('Slot 3', '(4pm-5pm)', scheduleData[index].slot3),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
        // Booking Tab
        Container(
          color: yl,
          padding: EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Form(
            key: _formKey,
            child: ListView(
              children: <Widget>[
                // Subject
                SizedBox(height: 40.0),
                Text('Subject', style: info),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: widget.subject,
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    fillColor: bl,
                  ),
                  onChanged: (val) {
                    setState(() => sb = val);
                  },
                ),
                // Date
                SizedBox(height: 40.0),
                Text('Date', style: info),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
    backgroundColor: yl, // Use backgroundColor instead of primary
  ),
  child: Text(
    _bookDate == null
        ? 'Pick Date'
        : DateFormat('yMd').format(_bookDate!).toString(),
  ),
  onPressed: () {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2025), // Extended date range
      cancelText: 'Cancel',
      confirmText: 'Select',
    ).then((date) {
      setState(() {
        _bookDate = date;
        dt = DateFormat('dd-MM-yyyy').format(_bookDate!); // Correct format
        dy = _bookDate!.day.toString();
      });
    });
  },
),

                // Slot
                SizedBox(height: 40.0),
                Text('Slot', style: info),
                DropdownButton<int>(
                  underline: Container(height: 1, color: bl),
                  hint: Text('Select Slot'),
                  value: sl,
                  items: [
                    DropdownMenuItem(child: Text('Slot 1: 8am-10am'), value: 1),
                    DropdownMenuItem(child: Text('Slot 2: 12pm-2pm'), value: 2),
                    DropdownMenuItem(child: Text('Slot 3: 4pm-5pm'), value: 3),
                  ],
                  onChanged: (val) {
                    setState(() {
                      sl = val;
                    });
                  },
                ),
                // Venue
                SizedBox(height: 40.0),
                Text('Location', style: info),
                TextFormField(
                  decoration: InputDecoration(
                    hintText: 'Tutor Venue',
                    enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.black)),
                    fillColor: bl,
                  ),
                  validator: (val) => val!.isEmpty ? 'Enter tutor venue!' : null,
                  onChanged: (val) {
                    setState(() => vn = val);
                  },
                ),
                // Book Button
                SizedBox(height: 50.0),
                ElevatedButton(
  style: ElevatedButton.styleFrom(
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(10))),
    backgroundColor: bl, // Use backgroundColor instead of primary
  ),
  onPressed: () async {
    if (_formKey.currentState!.validate()) {
      await _session.addTutorSession(
          widget.idTutor, user.uid, widget.subject, dt, dy, sl, vn);
    }
  },
  child: Container(
    padding: EdgeInsets.symmetric(vertical: 18),
    child: Text(
      'Book',
      style: TextStyle(color: Colors.white, fontSize: 15.0, letterSpacing: 1.5),
    ),
  ),
),

              ],
            ),
          ),
        ),
      ],
    ),
  );
}

// Helper method to build profile list tiles
Widget _buildProfileListTile(String titleText, String subtitleText) {
  return ListTile(
    title: Text(titleText, style: title), // Use defined title TextStyle
    subtitle: Text(subtitleText, style: info), // Use defined info TextStyle
  );
}


// Helper method to build slot widgets
Widget _buildSlotWidget(String slot, String time, bool isAvailable) {
  return Container(
    margin: EdgeInsets.only(top: 10),
    child: SizedBox(
      width: double.infinity,
      height: 50,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        color: isAvailable ? Colors.greenAccent : Colors.redAccent,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(slot, style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            Text(time, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    ),
  );
}

// Helper method to get day name
String _getDayName(String dayId) {
  switch (dayId) {
    case "mon": return 'Monday';
    case "tue": return 'Tuesday';
    case "wed": return 'Wednesday';
    case "thu": return 'Thursday';
    case "fri": return 'Friday';
    case "sat": return 'Saturday';
    case "sun": return 'Sunday';
    default: return 'Unknown';
  }
}
}