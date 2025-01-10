import 'package:flutter_application_1/controller/ratedata.dart';
import 'package:flutter_application_1/model/rate.dart';
import 'package:flutter_application_1/view/home/users/tutee/mainTutee/sessionTutee/historyTutee.dart';
import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

class HistoryWrapper extends StatelessWidget {
  final String uid;

  HistoryWrapper({required this.uid});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<Rate>(
      stream: RateDataService(uid: uid).rating,
      builder: (BuildContext context, AsyncSnapshot<Rate> snapshot) {
        // Check the connection state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator()); // Loading state
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}')); // Error state
        } else if (!snapshot.hasData || snapshot.data == null) {
          return Center(child: Text('No ratings found.')); // No data state
        }

        final rateData = snapshot.data!;
        return HistoryTutee(rate: rateData); // Return the widget with rate data
      },
    );
  }
}
