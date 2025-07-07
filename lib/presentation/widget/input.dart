import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final bool? leftHintDirection;
  const Input({
    super.key,
    required this.hintText, required this.controller, this.obscureText, this.leftHintDirection}) ;


  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 61,
      child: Card(
        elevation: 0,
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              hintText: hintText,
              hintTextDirection:leftHintDirection!=null? TextDirection.ltr:TextDirection.rtl,
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
