// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter_application_1/controller/scheduledata.dart';
import 'package:flutter_application_1/model/global.dart';
import 'package:flutter_application_1/model/profile.dart';
import 'package:flutter_application_1/model/schedule.dart';
import 'package:flutter_application_1/view/home/loading.dart';
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:timeline_tile/timeline_tile.dart';

class ScheduleTutor extends StatefulWidget {
  @override
  _ScheduleTutorState createState() => _ScheduleTutorState();
}

class _ScheduleTutorState extends State<ScheduleTutor> {
  DateTime today = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final profile = Provider.of<Profile>(context);
    final String hd = 'Schedule';

    String day = DateFormat.E().format(DateTime.now());
    // double width = MediaQuery.of(context).size.width;

    List<String> _scheduleDay = ['Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday', 'Saturday', 'Sunday'];

    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        child: Header(hd: hd, bl: bl, wy: wy),
        preferredSize: Size.fromHeight(80.0),
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
          child: StreamBuilder<List<Schedule>>(
            stream: ScheduleDataService(uid: profile.uid).schedule,
            builder: (BuildContext context, AsyncSnapshot<List<Schedule>> snapshot) {
              if (snapshot.hasData) {
                List<Schedule> scheduleData = snapshot.data ?? []; // Default value

                return ListView.builder(
                  itemCount: scheduleData.length,
                  itemBuilder: (context, index) {
                    bool _slot1 = scheduleData[index].slot1;
                    bool _slot2 = scheduleData[index].slot2;
                    bool _slot3 = scheduleData[index].slot3;

                    return TimelineTile(
                      beforeLineStyle: LineStyle(
                        color: bl,
                        thickness: 3,
                      ),
                      afterLineStyle: LineStyle(
                        color: bl,
                        thickness: 3,
                      ),
                      lineXY: 0,
                      indicatorStyle: IndicatorStyle(
                        color: scheduleData[index].id == day.toLowerCase() ? wy : bl,
                        padding: EdgeInsets.only(left: 15, right: 15),
                        width: 13,
                        indicatorXY: 0.1,
                      ),
                      alignment: TimelineAlign.start,
                      endChild: Container(
                        margin: EdgeInsets.only(bottom: 20),
                        color: yl,
                        child: Container(
                          padding: EdgeInsets.only(left: 20, right: 30, top: 17, bottom: 30),
                          color: scheduleData[index].id == day.toLowerCase() ? wy : yl,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              SizedBox(
                                height: 35,
                                child: Text(
                                  _scheduleDay[index],
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                              // slot1
                              SizedBox(
                                width: double.infinity,
                                height: 50,
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: scheduleData[index].slot1 ? Colors.redAccent : Colors.greenAccent,
                                  ),
                                  onPressed: () async {
                                    _slot1 = !_slot1;
                                    await ScheduleDataService(uid: profile.uid).updateScheduleData(
                                      scheduleData[index].id,
                                      'slot1',
                                      _slot1,
                                    );
                                  },
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: <Widget>[
                                      Text('Slot 1', style: TextStyle(fontSize: 15)),
                                      Text("(8am-10am)", style: TextStyle(fontSize: 15)),
                                    ],
                                  ),
                                ),
                              ),
                              // slot2
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: scheduleData[index].slot2 ? Colors.redAccent : Colors.greenAccent,
                                    ),
                                    onPressed: () async {
                                      _slot2 = !_slot2;
                                      await ScheduleDataService(uid: profile.uid).updateScheduleData(
                                        scheduleData[index].id,
                                        'slot2',
                                        _slot2,
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Slot 2', style: TextStyle(fontSize: 15)),
                                        Text("(12pm-2pm)", style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              // slot3
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: SizedBox(
                                  width: double.infinity,
                                  height: 50,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: scheduleData[index].slot3 ? Colors.redAccent : Colors.greenAccent,
                                    ),
                                    onPressed: () async {
                                      _slot3 = !_slot3;
                                      await ScheduleDataService(uid: profile.uid).updateScheduleData(
                                        scheduleData[index].id,
                                        'slot3',
                                        _slot3,
                                      );
                                    },
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text('Slot 3', style: TextStyle(fontSize: 15)),
                                        Text("(4pm-5pm)", style: TextStyle(fontSize: 15)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return Center(
                  child: Loading(),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
