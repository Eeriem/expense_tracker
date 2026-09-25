import 'package:flutter/material.dart';
import 'signin_screen.dart';      // ← your Sign In file
import 'signup_screen.dart';      // ← your Sign Up file (note the spelling)
import 'homescreen.dart';         // ← your Home file

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MyMoney',
      initialRoute: '/login',
      routes: {
        '/login': (context) => const SignInScreen(),      // from signin_screen.dart
        '/signup': (context) => const SignUpScreen(),     // from signup_screen.dart
        '/home': (context) => const HomeScreen(),         // from homescreen.dart
      },
    );
  }
}