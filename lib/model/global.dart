import 'package:flutter/material.dart';
//import 'package:flutter_applicatiion_1/model/subject.dart';

const Color yl = Color(0xffF0C742);
const Color wy = Colors.white;
const Color bl = Colors.black;

// Accept/reject button colors
const Color rd = Color(0xffF36A68);
const Color gn = Color(0xff75E6A2);

const TextStyle sb = TextStyle(fontSize: 19, fontWeight: FontWeight.w600);
const TextStyle nm = TextStyle(fontWeight: FontWeight.w400);

// List of subjects
class GridLayout {
  final String title;
  final String subtitle;

  const GridLayout(this.title, this.subtitle);
}
const List<GridLayout> subjectList = [
  GridLayout('Malay', 'Bahasa Melayu'),
  GridLayout('English', 'Bahasa Inggeris'),
  GridLayout('Science', 'Sains'),
  GridLayout('Mathematics', 'Matematik'),
  GridLayout('History', 'Sejarah'),
  GridLayout('Moral Education', 'Pendidikan Moral'),
  GridLayout('Islamic Education', 'Pendidikan Islam'),
  GridLayout('Add. Mathematics', 'Matematik Tambahan'),
  GridLayout('Chemistry', 'Kimia'),
  GridLayout('Biology', 'Biologi'),
  GridLayout('Physics', 'Fizik'),
  GridLayout('Economics', 'Ekonomi'),
];
