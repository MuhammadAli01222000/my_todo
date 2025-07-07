import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:my_todo/core/constants/app_colors.dart';
import 'package:my_todo/presentation/pages/auth/sign_in.dart' hide Input;
import 'package:my_todo/presentation/pages/home/home_page.dart';
import 'package:my_todo/presentation/widget/backround_color.dart';
import 'package:my_todo/presentation/widget/google_button.dart';
import 'package:my_todo/presentation/widget/login_button.dart';
import 'package:my_todo/routes/path_router.dart';

import '../../../core/constants/app_icons.dart';
import '../../../l10n/app_localizations.dart';
import '../../widget/input.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _usernameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  @override
  void dispose() {
    super.dispose();
    _passwordController.dispose();
    _lastNameController.dispose();
    _usernameController.dispose();
    _emailController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BackgroundColors(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(width: 10),
                Align(
                  alignment: Alignment(-0.9, -0.9),
                  child: AppIcons.todoHive,
                ),
                const Spacer(),
                Align(
                  alignment: Alignment.topRight,
                  child: SizedBox(child: AppIcons.pattern2),
                ),
              ],
            ),
            Center(
              child: Text(
                "${AppLocalizations.of(context)?.signUp}",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 21.2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: SizedBox(
                height: 110,
                width: 110,
                child: Card(
                  elevation: 0.00,
                  color: Color(0xFFFACDCDFF),
                  shape: CircleBorder(),
                  child: Padding(
                    padding: EdgeInsetsGeometry.all(3),
                    child: AppIcons.user,
                  ),
                ),
              ),
            ),
            Input(
              hintText: '${AppLocalizations.of(context)?.userName}',
              controller: _usernameController,
              leftHintDirection: true,
            ),
            const SizedBox(height: 15),

            Input(
              hintText: '${AppLocalizations.of(context)?.email}',
              controller: _emailController,
              leftHintDirection: true,
            ),
            const SizedBox(height: 15),

            Input(
              hintText: '${AppLocalizations.of(context)?.userName}',
              controller: _lastNameController,
              leftHintDirection: true,
            ),
            const SizedBox(height: 15),

            Input(
              hintText: '${AppLocalizations.of(context)?.userName}',
              controller: _passwordController,
              obscureText: true,
              leftHintDirection: true,
            ),
            const SizedBox(height: 15),

            LoginButton(onTap: () {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>HomePage()));

            //  context.goNamed(AppRouteName.home);
            }, text: '${AppLocalizations.of(context)?.signUp}'),
            const SizedBox(height: 15),
            GoogleButton(onTap: () {}),
            const SizedBox(height: 15),
          GestureDetector(
            onTap:(){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>SignInPage()));},
            child:   RichText(
              text: TextSpan(
                children: [
                  TextSpan(text: "${AppLocalizations.of(context)?.haveAccount   }",style: TextStyle(color: AppColors.black,fontSize: 13)),
                  TextSpan(
                    text: "${AppLocalizations.of(context)?.signIn}",
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,

                      decoration: TextDecoration.underline,
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ),
          ),



          ],
        ),
      ),
    );
  }
}
