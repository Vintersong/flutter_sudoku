import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flutter/material.dart';
import '../../core/theme.dart';

class CellComponent extends PositionComponent with TapCallbacks {
  final int row;
  final int col;
  int value;
  bool isInitial;
  bool isSelected = false;
  bool isHighlighted = false;
  bool isError = false;

  final VoidCallback? onTap;

  late Paint borderPaint;
  late Paint fillPaint;
  late TextPainter textPainter;

  CellComponent({
    required this.row,
    required this.col,
    required this.value,
    required this.isInitial,
    this.onTap,
  }) : super(size: Vector2.all(50));

  @override
  Future<void> onLoad() async {
    borderPaint = Paint()
      ..color = CyberpunkTheme.neonCyan.withOpacity(0.5)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1;

    fillPaint = Paint()..color = Colors.transparent;

    _updatePainter();
  }

  void _updatePainter() {
    textPainter = TextPainter(
      text: TextSpan(
        text: value == 0 ? '' : '$value',
        style: TextStyle(
          color: isInitial ? Colors.white : CyberpunkTheme.neonCyan,
          fontSize: 24,
          fontWeight: FontWeight.bold,
          shadows: [
            if (!isInitial)
              Shadow(
                color: CyberpunkTheme.neonCyan.withOpacity(0.8),
                blurRadius: 10,
              ),
          ],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();
  }

  @override
  void render(Canvas canvas) {
    // Background fill
    if (isSelected) {
      fillPaint.color = CyberpunkTheme.neonCyan.withOpacity(0.2);
    } else if (isHighlighted) {
      fillPaint.color = Colors.white.withOpacity(0.05);
    } else {
      fillPaint.color = Colors.transparent;
    }

    if (isError) {
      fillPaint.color = CyberpunkTheme.neonPink.withOpacity(0.2);
    }

    canvas.drawRect(size.toRect(), fillPaint);

    // Border
    borderPaint.color = isSelected
        ? CyberpunkTheme.neonCyan
        : CyberpunkTheme.neonCyan.withOpacity(0.3);
    borderPaint.strokeWidth = isSelected ? 2 : 1;

    canvas.drawRect(size.toRect(), borderPaint);

    // Number
    if (value != 0) {
      textPainter.paint(
        canvas,
        Offset(
          (size.x - textPainter.width) / 2,
          (size.y - textPainter.height) / 2,
        ),
      );
    }
  }

  @override
  void onTapDown(TapDownEvent event) {
    onTap?.call();
  }

  void updateValue(int newValue) {
    if (isInitial) return;
    value = newValue;
    _updatePainter();
  }
}
