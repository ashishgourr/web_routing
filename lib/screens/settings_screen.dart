import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({
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
          "SETTINGS SCREEN",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }
}
