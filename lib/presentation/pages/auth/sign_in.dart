import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/core/constants/app_colors.dart';
import 'package:my_todo/core/constants/app_dimens.dart';
import 'package:my_todo/core/constants/app_icons.dart';
import 'package:my_todo/presentation/pages/auth/sign_up.dart';
import 'package:my_todo/presentation/widget/backround_color.dart';
import 'package:my_todo/routes/path_router.dart';
import '../../../core/services/auth_service_impl.dart';
import '../../../l10n/app_localizations.dart';
import '../../widget/google_button.dart';
import '../../widget/login_button.dart';
// importlar o‘zgartirilmagan

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    final l10n = AppLocalizations.of(context)!;

    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      _showSnackBar(l10n.inputError);
      return;
    }

    if (!_isValidEmail(_emailController.text.trim())) {
      _showSnackBar(l10n.validEmailError);
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      await AuthService().signIn(
        _emailController.text.trim(),
        _passwordController.text.trim(),
      );
      print('✅ Login success');

      if (mounted) {
        context.goNamed(AppRouteName.home);
      }
    } on FirebaseAuthException catch (e) {
      final errorMessage = _getErrorMessage(e.code);
      _showSnackBar(errorMessage);
      print('❌ FirebaseAuth Error: ${e.code} - ${e.message}');
    } catch (_) {
      _showSnackBar(l10n.loginUnknownError);
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  String _getErrorMessage(String errorCode) {
    final l10n = AppLocalizations.of(context)!;

    switch (errorCode) {
      case 'user-not-found':
        return l10n.loginUserNotFound;
      case 'wrong-password':
        return l10n.loginWrongPassword;
      case 'invalid-email':
        return l10n.loginInvalidEmail;
      case 'user-disabled':
        return l10n.loginUserDisabled;
      case 'too-many-requests':
        return l10n.loginTooManyRequests;
      case 'network-request-failed':
        return l10n.loginNetworkFailed;
      case 'invalid-credential':
        return l10n.loginInvalidCredential;
      default:
        return 'errorCode';
    }
  }

  void _showSnackBar(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: BackgroundColors(
        child: Column(
          children: [
            Align(alignment: Alignment.topLeft, child: AppIcons.pattern1),
            Align(alignment: Alignment.topCenter, child: AppIcons.todoHive),
            Spacer(),
            Text("Login", style: TextStyle(color: Colors.black, fontSize: 50)),
            Spacer(),

            Container(
              width: 284,
              height: 350,
              color: Colors.transparent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Input(
                    hintText: l10n.email,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 8),
                  Input(
                    controller: _passwordController,
                    hintText: l10n.password,
                    obscureText: true,
                  ),
                  const SizedBox(height: 8),
                  LoginButton(onTap: _login, text: l10n.login),
                  const SizedBox(height: 8),
                  GoogleButton(onTap: () {}),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () {
                      context.goNamed(AppRouteName.signUp);
                    },
                    child: Text.rich(
                      TextSpan(
                        children: [
                          TextSpan(
                            text: l10n.dontHaveAccount,
                            style: const TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w400,
                            ),
                          ),
                          TextSpan(
                            text: " ${l10n.signUp}",
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            Align(alignment: Alignment.bottomRight, child: AppIcons.pattern2),
          ],
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String hintText;
  final TextEditingController controller;
  final bool? obscureText;
  final TextInputType? keyboardType;

  const Input({
    super.key,
    required this.hintText,
    required this.controller,
    this.obscureText,
    this.keyboardType,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 320,
      height: 61,
      child: Card(
        color: Colors.white70,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            obscureText: obscureText ?? false,
            keyboardType: keyboardType,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: GoogleFonts.inter(color: Colors.grey),
              border: InputBorder.none,
            ),
          ),
        ),
      ),
    );
  }
}
