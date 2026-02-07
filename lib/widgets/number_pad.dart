import 'package:flutter/material.dart';
import '../core/theme.dart';

class NumberPad extends StatelessWidget {
  final Function(int) onNumberSelected;

  const NumberPad({super.key, required this.onNumberSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List.generate(
              5,
              (index) => _buildNumberButton(index + 1),
            ),
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ...List.generate(4, (index) => _buildNumberButton(index + 6)),
              _buildClearButton(),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildNumberButton(int number) {
    return InkWell(
      onTap: () => onNumberSelected(number),
      child: Container(
        width: 50,
        height: 50,
        decoration: CyberpunkTheme.neonBox(color: CyberpunkTheme.neonCyan),
        child: Center(
          child: Text(
            '$number',
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildClearButton() {
    return InkWell(
      onTap: () => onNumberSelected(0),
      child: Container(
        width: 50,
        height: 50,
        decoration: CyberpunkTheme.neonBox(color: CyberpunkTheme.neonPink),
        child: const Center(child: Icon(Icons.backspace, color: Colors.white)),
      ),
    );
  }
}
