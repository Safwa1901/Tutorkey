// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_vector_icons/flutter_vector_icons.dart';

class Header extends StatelessWidget {
  const Header({
    Key? key, // Mark key as nullable
    required this.hd, // Use required for non-nullable parameters
    required this.bl,
    required this.wy,
  }) : super(key: key);

  final String hd; // Header title
  final Color bl; // Color for text and icons
  final Color wy; // Background color

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        onPressed: () {
          Navigator.pop(context); // Navigate back on button press
        },
        icon: Icon(
          Feather.chevron_left,
          color: bl, // Icon color
          size: 35,
        ),
      ),
      centerTitle: true, // Center the title
      elevation: 0, // No shadow
      backgroundColor: wy, // Background color
      title: Text(
        hd, // Header text
        style: TextStyle(
          color: bl, // Text color
          fontSize: 27,
          fontWeight: FontWeight.bold,
          letterSpacing: 1,
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(bottomRight: Radius.circular(40)),
      ), // Rounded bottom right corner
    );
  }
}
