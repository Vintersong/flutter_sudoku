import 'package:flutter/material.dart';
import 'core/theme.dart';
import 'screens/grid_sandbox_screen.dart';

void main() {
  runApp(const CyberSudokuApp());
}

class CyberSudokuApp extends StatelessWidget {
  const CyberSudokuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cyber Sudoku',
      theme: CyberpunkTheme.theme,
      home: const GridSandboxScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
