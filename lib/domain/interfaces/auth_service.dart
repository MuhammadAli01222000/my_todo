import 'package:firebase_auth/firebase_auth.dart';

abstract class IAuthService {
  Future<UserCredential> signIn(String email, String password);
  Future<UserCredential> signUp(String email, String password);
  Future<void> signOut();

  Future<bool> get isLoggedIn;
  Future<Map<String, dynamic>?> getUserFromLocal();

  User? get currentUser;
  Stream<User?> get authStateChanges;
}
