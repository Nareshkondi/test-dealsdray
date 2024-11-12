import 'package:flutter/material.dart';
import 'package:flutter_machine_test/homescreen.dart';
import 'package:flutter_machine_test/loginscreen.dart';
import 'package:flutter_machine_test/otpverificationscreen.dart';
import 'package:flutter_machine_test/splashscreen.dart';
import 'package:flutter_machine_test/userdetailsscreen.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/otp': (context) => OtpVerificationScreen(phoneNumber: '1234567890'),
        '/userDetails': (context) => UserDetailsScreen(),
        '/home': (context) => const HomeScreen(),
      },
    );
  }
}