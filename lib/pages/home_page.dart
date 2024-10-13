import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:labshared_pref/pages/another_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Declare your variable for data
  String? myName;

  // Declare your function to load data
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

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50], // Set a background color
      appBar: AppBar(
        title: const Text("Home Page"),
        backgroundColor: Colors.blueAccent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Name display inside a card
              Card(
                elevation: 8, // Increased elevation for a more pronounced shadow
                shadowColor: Colors.blueAccent.withOpacity(0.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                color: Colors.white, // Changed to white for better contrast
                child: Padding(
                  padding: const EdgeInsets.all(30.0), // Increased padding
                  child: Column(
                    children: [
                      const Text(
                        "ชื่อของคุณ",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.blueAccent,
                        ),
                      ),
                      const SizedBox(height: 15),
                      Text(
                        myName ?? "รอสักครู่...",
                        style: const TextStyle(
                          fontSize: 28, // Increased font size for better visibility
                          fontWeight: FontWeight.w600,
                          color: Colors.black87,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 60), // Increased spacing for better layout

              // Button to go to Another Page
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => const AnotherPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 60, // Adjusted button padding
                    vertical: 20,
                  ),
                  backgroundColor: Colors.blueAccent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 8, // Increased button elevation for a 3D effect
                ),
                child: const Text(
                  'Go to Another Page',
                  style: TextStyle(
                    fontSize: 20, // Increased button text size
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
