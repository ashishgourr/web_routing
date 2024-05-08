import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: const Text('My Page'),
      ),
      body: const Center(
        child: Text(
          "PROFILE SCREEN",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }
}
