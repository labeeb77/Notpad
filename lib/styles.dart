
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppStyle{
  static Color bgColor = Colors.black;

  static List<Color> cardColor = [
    Colors.white,
    Colors.red.shade300,
    Colors.pink.shade300,
    Colors.orange.shade300,
    Colors.yellow.shade300,
    Colors.green.shade300,
    Colors.blue.shade300,
    Colors.blueGrey.shade300
    
  ];

  static TextStyle mainTitle = GoogleFonts.roboto(fontSize: 18,fontWeight: FontWeight.bold,color: Colors.white);
  static TextStyle mainContent = GoogleFonts.nunito(fontSize: 16,fontWeight: FontWeight.normal,color: Colors.white);
  static TextStyle dateTitle = GoogleFonts.roboto(fontSize: 13,fontWeight: FontWeight.w500,color: Colors.white);
}