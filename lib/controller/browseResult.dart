// ignore_for_file: prefer_const_constructors, prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';
import 'package:flutter_application_1/controller/browsedetails.dart';

class BrowseResult extends StatefulWidget {
  final String exam;
  final String subject;

  BrowseResult({Key? key, required this.exam, required this.subject}) : super(key: key);

  @override
  _BrowseResultState createState() => _BrowseResultState();
}

class _BrowseResultState extends State<BrowseResult> {
  // Styling colors
  final Color yl = Color(0xffF0C742);
  final Color wy = Colors.white;
  final Color bl = Colors.black;
  final TextStyle torName = TextStyle(fontSize: 21.0, fontWeight: FontWeight.bold);
  final TextStyle subText = TextStyle(fontSize: 16.0);

  @override
  Widget build(BuildContext context) {
    print("firebase instanc####################e");
    print(FirebaseFirestore.instance
                .collection('subjects')
                .doc(widget.exam)
                .collection(widget.subject)
                );
    print('Exam: ${widget.exam}, Subject: ${widget.subject}');
    print('Length of exam: ${widget.exam.length}');
print('Length of subject: ${widget.subject.length}');

print('Firestoreeeeeeeeeeerrerrerfdtrgfvcdgdvfctvdfcdvfcdvfc Path: subjects/${widget.exam}/${widget.subject}');
// FirebaseFirestore.instance
//   .collection('subjects')
//   .doc('spm')
//   .collection('biology')
//   .get()
//   .then((QuerySnapshot snapshot) {
//     print("Snapshot data: ${snapshot.docs.length} documents found");
//     snapshot.docs.forEach((doc) {
//       print("Document ID: ${doc.id}, Data: ${doc.data()}");
//     });
//   }).catchError((e) {
//     print("Error: $e");
//   });
    return Scaffold(
      backgroundColor: yl,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80.0),
        child: _Appbar(bl: bl, wy: wy, sb: widget.subject),
      ),
      body: Container(
        color: wy,
        child: Container(
          padding: EdgeInsets.only(top: 20, left: 10, right: 8),
          decoration: BoxDecoration(
            color: yl,
            borderRadius: BorderRadius.only(topLeft: Radius.circular(40)),
          ),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance
                .collection('subjects')
                .doc(widget.exam.trim())
                .collection(widget.subject.trim().toLowerCase())
                .snapshots(),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              print('Snapshot ConnectionState: ${snapshot.connectionState}');
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(child: CircularProgressIndicator());
              }
              for (var doc in snapshot.data!.docs) {
              print("Document ID: ${doc.id}, Data: ${doc.data()}");
            }
              print("snapshot recievede issssssssssss");
              print(snapshot);
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
            // if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            //       print('Snapshot is empty or no documents.');
            //       return Center(child: Text('Sorry, no tutors available for this subject.'));
            //     }
              if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
                print("snappppppa errrrrrrrororororo");

                return ListView(
                  children: snapshot.data!.docs.map((document) {
                    return Container(
                      color: yl,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 20.0),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.all(20),
                            backgroundColor: wy,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20.0),
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Text(
                                    document['name'] ?? 'No Name Available',
                                    style: torName,
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    'RM' + (document['price']?.toStringAsFixed(2) ?? '0.00') + ' /hour',
                                    style: subText,
                                  ),
                                ],
                              ),
                              ClipOval(
                                child: SizedBox(
                                  height: 100.0,
                                  width: 100.0,
                                  child: Image.network(
                                    document['img'] ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (context, error, stackTrace) {
                                      return Icon(Icons.error, size: 50);
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BrowseDetails(
                                  idTutor: document.id,
                                  subject: widget.subject,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    );
                  }).toList(),
                );
              } else {
                return Center(
                  child: Text('Sorry, no tutors available for this subject.'),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class _Appbar extends StatelessWidget {
  const _Appbar({
    Key? key,
    required this.bl,
    required this.wy,
    required this.sb,
  }) : super(key: key);

  final Color bl;
  final Color wy;
  final String sb;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Feather.chevron_left,
          color: bl,
          size: 35,
        ),
      ),
      centerTitle: true,
      elevation: 0,
      backgroundColor: wy,
      title: Text(
        sb.toUpperCase(),
        style: TextStyle(
          color: bl,
          fontSize: 27,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
      ),
    );
  }
}
