import 'package:firebase_auth/firebase_auth.dart';

class AuthController {
  final _auth = FirebaseAuth.instance;
  Future<void> signInAnonymously() async {
    await _auth.signInAnonymously();
  }

  User? get currentUser => _auth.currentUser;
}
