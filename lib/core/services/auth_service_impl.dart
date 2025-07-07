import 'package:firebase_auth/firebase_auth.dart';
import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import '../../domain/interfaces/auth_service.dart';

class AuthService implements IAuthService{
  final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String _userBoxName = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _userIdKey = 'user_id';
  static const String _userEmailKey = 'user_email';

  Future<Box> get _userBox async => await Hive.openBox(_userBoxName);
  @override
  Future<UserCredential> signIn(String email, String password) async {
    try {
      UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserToLocal(result.user!);

      return result;
    } catch (e) {
      debugPrint('SignIn Error: $e');
      rethrow;
    }
  }
  @override
  Future<UserCredential> signUp(String email, String password) async {
    try {
      UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await _saveUserToLocal(result.user!);

      return result;
    } catch (e) {
      debugPrint('SignUp Error: $e');
      rethrow;
    }
  }
  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();

      await _clearUserFromLocal();

    } catch (e) {
      debugPrint('SignOut Error: $e');
      rethrow;
    }
  }
  Future<void> _saveUserToLocal(User user) async {
    try {
      final box = await _userBox;
      await box.put(_isLoggedInKey, true);
      await box.put(_userIdKey, user.uid);
      await box.put(_userEmailKey, user.email);

      debugPrint('✅ User saved to local storage: ${user.email}');
    } catch (e) {
      debugPrint('❌ Error saving user to local: $e');
    }
  }
  Future<void> _clearUserFromLocal() async {
    try {
      final box = await _userBox;
      await box.clear();

    } catch (e) {
    }
  }
  @override

  Future<bool> get isLoggedIn async {
    try {
      final box = await _userBox;
      final isLoggedIn = box.get(_isLoggedInKey, defaultValue: false);
      final currentUser = _auth.currentUser;

      return isLoggedIn && currentUser != null;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> checkLoginStatus() async {
    final authService = AuthService();
    return await authService.isLoggedIn;
  }

  @override
  Future<Map<String, dynamic>?> getUserFromLocal() async {
    try {
      final box = await _userBox;
      final userId = box.get(_userIdKey);
      final userEmail = box.get(_userEmailKey);
      final isLoggedIn = box.get(_isLoggedInKey, defaultValue: false);

      if (userId != null && userEmail != null && isLoggedIn) {
        return {
          'userId': userId,
          'userEmail': userEmail,
          'isLoggedIn': isLoggedIn,
        };
      }
      return null;
    } catch (e) {
      debugPrint('❌ Error getting user from local: $e');
      return null;
    }
  }

  @override
  User? get currentUser => _auth.currentUser;

  @override
  Stream<User?> get authStateChanges => _auth.authStateChanges();
}