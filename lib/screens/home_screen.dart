import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop(); // Navigate back when pressed
          },
        ),
        title: const Text('My Page'),
      ),
      body: const Center(
        child: Text(
          "HOME SCREEN",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }
}
