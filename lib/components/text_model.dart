import 'package:flutter/material.dart';
import 'package:demofood/constants/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class TextModel extends StatelessWidget {
  final String stringName;

  const TextModel({super.key, required this.stringName});

  @override
  Widget build(BuildContext context) {
    return Text(
      "$stringName",
      style: GoogleFonts.montserrat(
          textStyle: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: baseColor)),
    );
  }
}
