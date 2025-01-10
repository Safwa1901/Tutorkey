// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_application_1/controller/browseResult.dart'; // Uncomment if needed

class GridLayout {
  final String eng;
  final String malay;

  // Constructor with required fields
  GridLayout({required this.eng, required this.malay});
}

class GridOptions extends StatelessWidget {
  final GridLayout layout;

  // Constructor with required layout parameter
  const GridOptions({Key? key, required this.layout}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(15)),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BrowseResult(
                exam: 'spm',
                subject: layout.eng.toLowerCase(),
              ),
            ),
          );
        },
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                layout.eng,
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                layout.malay,
                style: TextStyle(
                  fontSize: 15,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
