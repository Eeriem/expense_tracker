import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F5E9),
      body: Center(
        child: TextButton(
          onPressed: () {
            Navigator.pushReplacementNamed(context, '/login');
          },
          child: const Text(
            'Back to Login',
            style: TextStyle(
              color: Color(0xFF2E7D32),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}