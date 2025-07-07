import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

class BackgroundColors extends StatelessWidget {
  final Widget? child;
  const BackgroundColors({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity, // Muhim!
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.yellow,
            AppColors.pink3,
            AppColors.yellow,
            AppColors.pink2,
          ],
        ),
      ),
      child: child,
    );
  }
}
