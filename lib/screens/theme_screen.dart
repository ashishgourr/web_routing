import 'package:flutter/material.dart';

class ThemeScreen extends StatelessWidget {
  const ThemeScreen({
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
          "THEME SCREEN",
          style: TextStyle(color: Colors.blue, fontSize: 16),
        ),
      ),
    );
  }
}
