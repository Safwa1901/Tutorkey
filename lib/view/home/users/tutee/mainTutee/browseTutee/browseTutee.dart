// ignore_for_file: prefer_const_constructors, prefer_const_declarations

import 'package:flutter_application_1/controller/browseResult.dart';
// import 'package:flutter_application_1/model/subject.dart' as subjectModel;
import 'package:flutter_application_1/view/home/users/globalWidgetTutor.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_application_1/model/global.dart' as globalmodel;

class BrowseTutee extends StatefulWidget {
  @override
  _BrowseTuteeState createState() => _BrowseTuteeState();
}

class _BrowseTuteeState extends State<BrowseTutee> {
  Color yl = Color(0xffF0C742);
  Color wy = Colors.white;
  Color bl = Colors.black;

  String exam = 'spm';
  final RoundedRectangleBorder subjCard = RoundedRectangleBorder(
    borderRadius: BorderRadius.circular(20.0),
  );

  final TextStyle subjName = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    // final double height = MediaQuery.of(context).size.height;
    final String hd = 'BROWSE';

    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: Header(hd: hd, bl: bl, wy: wy),
      ),
      body: Container(
        color: wy,
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 8),
          decoration: BoxDecoration(
            color: yl,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(40),
            ),
          ),
          child: GridView.count(
            childAspectRatio: 1.5,
            crossAxisCount: 2,
            crossAxisSpacing: 18,
            mainAxisSpacing: 18,
            padding: EdgeInsets.all(10.0),
            children: List.generate(
              globalmodel.subjectList.length,
              (index) => _buildSubjectCard(context, globalmodel.subjectList[index]),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSubjectCard(BuildContext context, globalmodel.GridLayout subject) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: subjCard,
        backgroundColor: wy,
      ),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => BrowseResult(exam: exam, subject: subject.title),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            subject.title,
            style: subjName.copyWith(fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 5),
          Text(
            subject.subtitle,
            style: subjName,
          ),
        ],
      ),
    );
  }
}

// class _Header extends StatelessWidget {
//   const _Header({
//     Key key,
//     @required this.yl,
//     @required this.header,
//     @required this.bl,
//   }) : super(key: key);

//   final Color yl;
//   final double header;
//   final Color bl;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       color: yl,
//       height: header,
//       child: Container(
//         padding: EdgeInsets.only(top: 15),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.only(
//             bottomRight: Radius.circular(40),
//           ),
//         ),
//         height: 140,
//         child: Row(
//           children: <Widget>[
//             Container(
//               child: IconButton(
//                   icon: Icon(
//                     Feather.chevron_left,
//                     color: bl,
//                     size: 35,
//                   ),
//                   onPressed: () {
//                     Navigator.pop(context);
//                   }),
//             ),
//             Center(
//               widthFactor: 2.5,
//               child: Text(
//                 'BROWSE',
//                 style: TextStyle(
//                   fontSize: 27,
//                   fontWeight: FontWeight.bold,
//                   letterSpacing: 1,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// body
// Expanded(
//   child: Container(
//     color: wy,
//     child: Container(
//       padding: EdgeInsets.only(
//         top: 20,
//         left: 15,
//         right: 15,
//       ),
//       decoration: BoxDecoration(
//         color: yl,
//         borderRadius: BorderRadius.only(
//           topLeft: Radius.circular(40),
//         ),
//       ),
//       child: GridView.count(
//         childAspectRatio: 1,
//         primary: false,
//         padding: const EdgeInsets.all(15),
//         crossAxisSpacing: 23,
//         mainAxisSpacing: 23,
//         crossAxisCount: 2,
//         children: <Widget>[
//           Container(
//             child: RaisedButton(
//               shape: subjCard,
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BrowseResult(
//                         exam: exam, subject: 'biology'),
//                   ),
//                 );
//               },
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Biology",
//                     style: subjName,
//                   ),
//                 ],
//               ),
//             ),
//           ),
//           Container(
//             child: RaisedButton(
//               shape: subjCard,
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Chemistry",
//                     style: subjName,
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BrowseResult(
//                         exam: exam, subject: 'chemistry'),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             child: RaisedButton(
//               shape: subjCard,
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Physic",
//                     style: subjName,
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) =>
//                         BrowseResult(exam: exam, subject: 'physic'),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             child: RaisedButton(
//               shape: subjCard,
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Mathematics",
//                     style: subjName,
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BrowseResult(
//                         exam: exam, subject: 'mathematics'),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             child: RaisedButton(
//               shape: subjCard,
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Additional Mathematics",
//                     style: subjName,
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BrowseResult(
//                         exam: exam,
//                         subject: 'additional mathematics'),
//                   ),
//                 );
//               },
//             ),
//           ),
//           Container(
//             child: RaisedButton(
//               shape: subjCard,
//               child: Column(
//                 children: <Widget>[
//                   Text(
//                     "Science",
//                     style: subjName,
//                   ),
//                 ],
//               ),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(
//                     builder: (context) => BrowseResult(
//                         exam: exam, subject: 'science'),
//                   ),
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     ),
//   ),
// ),
