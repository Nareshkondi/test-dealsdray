import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_machine_test/homescreen.dart';
import 'package:flutter_machine_test/loginscreen.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final Dio _dio = Dio();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _referralController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _registerUser() async {
    const url = "http://devapiv4.dealsdray.com/api/v2/user/email/referral";
    final data = {
      "email": _emailController.text,
      "password": _passwordController.text,
      "referralCode": _referralController.text.isNotEmpty ? int.tryParse(_referralController.text) : null,
      "userId": await _getUserId(),
    };

    try {
      final response = await _dio.post(url, data: data);

      if (response.statusCode == 200) {
        print("Registration successful");
        Navigator.pushReplacement(context,MaterialPageRoute(builder: (context)=>const HomeScreen())); // Navigate to home screen after registration
      } else {
        print("Registration failed: ${response.statusCode}");
      }
    } catch (error) {
      print("Error during registration: $error");
    }
  }

  Future<String> _getUserId() async {
    // Retrieve or generate user ID (adjust this method based on your app's requirements)
    // This is a placeholder; replace with actual user ID retrieval if necessary
    return "user_id_here"; 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        onTap: () {
          // Dismiss the keyboard when tapping outside input fields
          FocusScope.of(context).unfocus();
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 40), // Top padding
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen())); // Go back to previous screen
                        },
                        child: const Icon(
                          Icons.chevron_left,
                          color: Colors.black,
                          size: 38,
                        ),
                      ),
                      Center(
                        child: Image.asset(
                          'assets/logo.png', // Replace with your logo
                          height: 220,
                        ),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Let's Begin!",
                        style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 5),
                      const Text(
                        "Please enter your credentials to proceed",
                        style: TextStyle(color: Colors.grey),
                      ),
                      const SizedBox(height: 30),
                      TextField(
                        controller: _emailController,
                        decoration: const InputDecoration(
                          labelText: "Your Email",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _passwordController,
                        obscureText: !_isPasswordVisible, // Toggle password visibility
                        decoration: InputDecoration(
                          labelText: "Create Password",
                          labelStyle: const TextStyle(color: Colors.grey),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: _isPasswordVisible ? Colors.red : Colors.grey,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                          enabledBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: const UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                      const SizedBox(height: 15),
                      TextField(
                        controller: _referralController,
                        decoration: const InputDecoration(
                          labelText: "Referral Code (Optional)",
                          labelStyle: TextStyle(color: Colors.grey),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.only(right: 10.0, bottom: 10.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: FloatingActionButton(
              backgroundColor: Colors.red,
              onPressed: _registerUser,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: const Icon(Icons.arrow_forward, color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}