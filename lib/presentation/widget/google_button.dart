import 'package:flutter/material.dart';
import 'package:my_todo/core/constants/app_colors.dart';

import '../../core/constants/app_icons.dart';
import '../../l10n/app_localizations.dart';

class GoogleButton extends StatelessWidget {
  final VoidCallback onTap;
  const GoogleButton({
    super.key, required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 61,
      child: Card(
        elevation: 0,
        color: Colors.white38,
        child: Center(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              AppIcons.google,
              SizedBox(width: 10),
              TextButton(
                onPressed: onTap,
                child: Text(  "${AppLocalizations.of(context)?.signInWidthGoogle}",
                  style: TextStyle(fontSize: 13,color: AppColors.black),
                ),),
            ],
          ),
        ),
      ),
    );
  }
}
