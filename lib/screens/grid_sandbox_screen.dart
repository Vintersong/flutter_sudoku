import 'package:flutter/material.dart';

class GridSandboxScreen extends StatelessWidget {
  const GridSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Text(
          'BLANK CANVAS',
          style: TextStyle(color: Colors.cyan, fontSize: 24),
        ),
      ),
    );
  }
}
