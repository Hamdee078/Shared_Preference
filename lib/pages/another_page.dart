import 'package:flutter/material.dart';

class AnotherPage extends StatefulWidget {
  const AnotherPage({super.key});

  @override
  State<AnotherPage> createState() => _AnotherPageState();
}

class _AnotherPageState extends State<AnotherPage> {
  // Declare your variable for data

  // Declare your function to load data

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Another Page"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Show Your name

            // Button go to Home Page

            // Button go to First Page
          ],
        ),
      ),
    );
  }
}
