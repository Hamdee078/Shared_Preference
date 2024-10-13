import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:labshared_pref/pages/home_page.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({super.key});

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  final TextEditingController _nameController = TextEditingController();

  void saveData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('myname', _nameController.text);
  }

  // Glassmorphism card style widget
  Widget glassmorphismCard(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.purple.withOpacity(0.2),
                Colors.purple.withOpacity(0.1),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.4),
                spreadRadius: 4,
                blurRadius: 20,
                offset: const Offset(0, 10), // Shadow position
              ),
            ],
          ),
          padding: const EdgeInsets.all(30),
          child: child,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/background.jpg'), // Replace with your image path
                fit: BoxFit.cover,
              ),
            ),
          ),
          Container(
            color: const Color(0xFF6D5DD7).withOpacity(0.6), // Semi-transparent overlay in purple
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: glassmorphismCard(
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'พิมพ์ชื่อของคุณ',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.purpleAccent,
                      ),
                    ),
                    const SizedBox(height: 20),
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'ชื่อ',
                        labelStyle: const TextStyle(color: Colors.white),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                        filled: true,
                        fillColor: Colors.purple.shade50,
                        prefixIcon: const Icon(Icons.person, color: Colors.purpleAccent),
                      ),
                      style: const TextStyle(fontSize: 18, color: Colors.black),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      onPressed: () {
                        if (_nameController.text.trim().isNotEmpty) {
                          // Save data to shared preferences
                          saveData();

                          // Navigate to HomePage
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => const HomePage()),
                          );
                        } else {
                          // Show error message if the name is empty
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("พิมพ์ชื่อก่อนนะตัวเอง"),
                            ),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        backgroundColor: Colors.purpleAccent, // Background color in purple
                        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                        elevation: 5,
                      ),
                      child: const Text(
                        'ยืนยัน',
                        style: TextStyle(fontSize: 20, color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
