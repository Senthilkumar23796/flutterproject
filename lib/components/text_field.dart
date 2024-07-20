import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final FormFieldValidator? validator;
  final List<TextInputFormatter>? inputFormat;
  final TextInputType? inputType;
  final Widget? trailingIcon;
  final bool isVisible;

  const MyTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.validator,
      this.inputFormat,
      this.inputType,
      this.trailingIcon,
      this.isVisible = false});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      validator: validator,
      controller: controller,
      inputFormatters: inputFormat,
      keyboardType: inputType,
      obscureText: isVisible,
      //Automaticall validate without pressing the submit button
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
          suffixIcon: trailingIcon,
          enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: const BorderSide(color: Colors.black)),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.black)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.black)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.0),
              borderSide: BorderSide(color: Colors.black)),
          hintText: hintText,
          hintStyle: GoogleFonts.montserrat(
              textStyle: TextStyle(fontWeight: FontWeight.w600))),
    );
  }
}
