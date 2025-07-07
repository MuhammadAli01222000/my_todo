import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/core/constants/app_colors.dart';
import 'package:my_todo/core/constants/app_dimens.dart';
import 'package:my_todo/l10n/app_localizations.dart';
import 'package:my_todo/routes/path_router.dart';

import '../../../core/constants/app_icons.dart';
import '../../../core/constants/text_style.dart';
import '../../../core/services/auth_service_impl.dart';
import '../../widget/backround_color.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}
// ok hammasi
class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    _checkAuthAndNavigate();
  }

  Future<void> _checkAuthAndNavigate() async {
    await Future.delayed(const Duration(seconds: 2));

    if (!mounted) return;

    try {
      final authService = AuthService();
      final bool isLoggedIn = await authService.isLoggedIn;

      print('🔍 Splash: Checking auth status - isLoggedIn: $isLoggedIn');

      if (isLoggedIn) {
        context.goNamed(AppRouteName.home);
      } else {
        context.goNamed(AppRouteName.login);
      }
    } catch (e) {
      print('❌ Splash: Error checking auth status: $e');
      context.goNamed(AppRouteName.login);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundColors(
        child: Column(
          children: [
            /// topleft vector
            Align(alignment: Alignment.topLeft, child: AppIcons.vector1),
            Align(alignment: Alignment.topLeft, child: AppIcons.vector2),
            AppDimens.h40,
            Center(child: AppIcons.todoHive),
            AppDimens.h16,

            Text("${AppLocalizations.of(context)?.splashScreenText}",style: AppTextStyle.splashText),
            AppDimens.h16,
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 100),
              child: OutlinedButton(
                onPressed: () {
                  context.goNamed(AppRouteName.login);
                },
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children:  [
                    Text("${AppLocalizations.of(context)?.getStarted}" ,style: AppTextStyle.splashText,),
                    SizedBox(width: 8),
                    AppIcons.arrowRight,
                  ],
                ),
              ),
            ),
            Spacer(),

            ///top right icon
            Align(alignment: Alignment.bottomRight, child: AppIcons.vector3),
          ],
        ),
      ),
    );
  }
}
