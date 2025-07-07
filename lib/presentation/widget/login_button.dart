import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final VoidCallback onTap;

  const LoginButton({
    required this.onTap,
    super.key, required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 61,
      child: Card(
        color: Colors.black,
        child: Center(
          child: TextButton(
            onPressed: onTap,
            child: TextButton(
              onPressed: onTap,
           child: Text(text,
              style: TextStyle(
                color: AppColors.white,
                fontStyle: FontStyle.italic,
                fontSize: 17,
              ),
           ),
            ),
          ),
        ),
      ),
    );
  }
}
