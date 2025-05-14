import 'package:flutter/material.dart';
import '../controllers/auth_controller.dart';
import 'chat_screen.dart';

class LoginScreen extends StatelessWidget {
  final _authController = AuthController();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1B1A2F),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.chat_bubble_outline_rounded,
                size: 100,
                color: Colors.deepPurpleAccent,
              ),
              const SizedBox(height: 24),
              const Text(
                'Welcome to SimpleChat',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 1.2,
                ),
              ),
              const SizedBox(height: 50),
              ElevatedButton.icon(
                icon: const Icon(Icons.login_rounded),
                label: const Text('Enter as Guest'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.deepPurpleAccent,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 14,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                onPressed: () async {
                  await _authController.signInAnonymously();
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (_) => ChatScreen()),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
