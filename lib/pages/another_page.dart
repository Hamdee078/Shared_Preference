import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labshared_pref/pages/first_page.dart';
import 'package:labshared_pref/pages/home_page.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  String? myName;

  // Load data from SharedPreferences
  void loadData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      myName = prefs.getString("myname");
    });
  }

  @override
  void initState() {
    loadData();
    super.initState();
  }

  // Glassmorphism card style widget
  Widget glassmorphismCard(Widget child) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15.0, sigmaY: 15.0),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.25), // Slightly more opacity for better visibility
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: Colors.white.withOpacity(0.6),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 15,
                offset: const Offset(0, 5), // changes position of shadow
              ),
            ],
          ),
          padding: const EdgeInsets.all(20),
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
            color: const Color(0xFFE0F7FA).withOpacity(0.6), // Semi-transparent overlay
          ),
          // App bar
          AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: const Text(
              "Another Page",
              style: TextStyle(color: Colors.white),
            ),
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF57D5E2), Color(0xFF004AAD)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  glassmorphismCard(
                    Column(
                      children: [
                        Text(
                          myName ?? "รอสักครู่...",
                          style: const TextStyle(
                            fontSize: 28,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 30),
                        // Button to Home Page
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => const HomePage()),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            backgroundColor: Colors.blueAccent.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Go to Home Page',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        // Button to First Page
                        ElevatedButton(
                          onPressed: () {
                            SharedPreferences.getInstance().then((prefs) {
                              prefs.remove("myname");
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const FirstPage()),
                              );
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                            backgroundColor: Colors.purpleAccent.withOpacity(0.8),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'Go to First Page',
                            style: TextStyle(
                              fontSize: 18,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
