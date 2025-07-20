import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Input extends StatefulWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final bool? leftHintDirection;

  const Input({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.leftHintDirection,
  });

  @override
  State<Input> createState() => _InputState();
}

class _InputState extends State<Input> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 61,
      child: Card(
        elevation: 0,
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: widget.controller,
                  obscureText: _obscure,
                  obscuringCharacter: '*',
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintTextDirection: widget.leftHintDirection != null
                        ? TextDirection.ltr
                        : TextDirection.rtl,
                    hintStyle: GoogleFonts.inter(color: Colors.grey),
                    border: InputBorder.none,
                  ),
                ),
              ),
              if (widget.obscureText == true)
                IconButton(
                  icon: Icon(
                    _obscure ? Icons.visibility_off : Icons.visibility,
                    color: Colors.grey,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscure = !_obscure;
                    });
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
