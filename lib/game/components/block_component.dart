import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'cell_component.dart';
import '../../core/theme.dart';

class SudokuBlock extends PositionComponent {
  final int blockRow;
  final int blockCol;
  final List<List<int>> initialValues;
  final Function(int row, int col) onCellTap;
  final List<List<CellComponent>> cells = List.generate(3, (_) => []);

  SudokuBlock({
    required this.blockRow,
    required this.blockCol,
    required this.initialValues,
    required this.onCellTap,
  }) : super(size: Vector2.all(50 * 3 + 2 * 2)) {
    const double cellSize = 50.0;
    const double gap = 2.0;

    for (int r = 0; r < 3; r++) {
      for (int c = 0; c < 3; c++) {
        final globalRow = blockRow * 3 + r;
        final globalCol = blockCol * 3 + c;

        final cell = CellComponent(
          row: globalRow,
          col: globalCol,
          value: initialValues[r][c],
          isInitial: initialValues[r][c] != 0,
          onTap: () => onCellTap(globalRow, globalCol),
        )..position = Vector2(c * (cellSize + gap), r * (cellSize + gap));

        cells[r].add(cell);
      }
    }
  }

  @override
  Future<void> onLoad() async {
    const double gap = 2.0;

    for (var row in cells) {
      for (var cell in row) {
        add(cell);
      }
    }

    // Add block border (glowing neon)
    add(
      RectangleComponent(
        position: Vector2(-gap, -gap),
        size: size + Vector2(gap * 2, gap * 2),
        paint: Paint()
          ..color = CyberpunkTheme.neonCyan
          ..style = PaintingStyle.stroke
          ..strokeWidth = 3
          ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 2),
      ),
    );
  }
}
