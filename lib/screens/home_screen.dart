import 'package:flutter/material.dart';
import '../core/theme.dart';
import 'game_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(color: CyberpunkTheme.background),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'CYBER',
              style: TextStyle(
                fontSize: 60,
                fontWeight: FontWeight.bold,
                color: CyberpunkTheme.neonPink,
                letterSpacing: 8,
                shadows: [
                  Shadow(
                    color: CyberpunkTheme.neonPink.withOpacity(0.8),
                    blurRadius: 20,
                  ),
                ],
              ),
            ),
            Text(
              'SUDOKU',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: CyberpunkTheme.neonCyan,
                letterSpacing: 4,
                shadows: [
                  Shadow(
                    color: CyberpunkTheme.neonCyan.withOpacity(0.8),
                    blurRadius: 15,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 80),
            _buildMenuButton(context, 'INITIALIZE GAME', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameScreen(difficulty: 0.3),
                ),
              );
            }),
            const SizedBox(height: 20),
            _buildMenuButton(context, 'HARD RESET', () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const GameScreen(difficulty: 0.7),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  Widget _buildMenuButton(
    BuildContext context,
    String text,
    VoidCallback onPressed,
  ) {
    return ElevatedButton(onPressed: onPressed, child: Text(text));
  }
}
