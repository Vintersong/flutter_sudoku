import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'components/cell_component.dart';
import 'components/block_component.dart';

class SudokuGame extends FlameGame {
  late List<List<CellComponent>> allCells;
  late List<SudokuBlock> blocks;
  int? selectedRow;
  int? selectedCol;

  final List<List<int>> initialGrid;
  final List<List<int>> solution;

  SudokuGame({required this.initialGrid, required this.solution});

  @override
  Future<void> onLoad() async {
    const double cellSize = 50.0;
    const double gap = 2.0;
    const double blockGap = 4.0;
    const double totalGridSize = (cellSize * 9) + (gap * 6) + (blockGap * 2);

    allCells = List.generate(9, (_) => List.filled(9, null as dynamic));
    blocks = [];

    for (int br = 0; br < 3; br++) {
      for (int bc = 0; bc < 3; bc++) {
        final blockInitialValues = List.generate(
          3,
          (r) => List.generate(3, (c) => initialGrid[br * 3 + r][bc * 3 + c]),
        );

        final block =
            SudokuBlock(
                blockRow: br,
                blockCol: bc,
                initialValues: blockInitialValues,
                onCellTap: selectCell,
              )
              ..position = Vector2(
                bc * (3 * cellSize + 2 * gap + blockGap),
                br * (3 * cellSize + 2 * gap + blockGap),
              );

        add(block);
        blocks.add(block);
      }
    }

    // After blocks are added, we need to wait for them to load or manually populate allCells
    // For simplicity in this logic, let's manually populate the references
    _populateCellReferences();

    // Center the grid and scale it to fit
    camera.viewfinder.anchor = Anchor.center;
    camera.viewfinder.position = Vector2(totalGridSize / 2, totalGridSize / 2);
    _updateZoom(totalGridSize);
  }

  void _populateCellReferences() {
    // We delay this or manually create them?
    // Actually, let's have blocks expose their cells after onLoad or create them synchronously.
    // I'll update SudokuBlock to create cells in constructor/init for sync access if needed.
    // For now, I'll just rely on the fact that blocks have their cells after they are added.
    for (var block in blocks) {
      for (int r = 0; r < 3; r++) {
        for (int c = 0; c < 3; c++) {
          allCells[block.blockRow * 3 + r][block.blockCol * 3 + c] =
              block.cells[r][c];
        }
      }
    }
  }

  void _updateZoom(double totalGridSize) {
    if (size.x == 0 || size.y == 0) return;
    // Fit the grid into the available game size
    final scale = min(size.x, size.y) / totalGridSize;
    camera.viewfinder.zoom = scale * 0.98; // Use 98% of available space
  }

  @override
  void onGameResize(Vector2 size) {
    super.onGameResize(size);
    const double cellSize = 50.0;
    const double gap = 2.0;
    const double totalGridSize = cellSize * 9 + gap * 8;
    _updateZoom(totalGridSize);
  }

  void selectCell(int r, int c) {
    if (selectedRow != null && selectedCol != null) {
      allCells[selectedRow!][selectedCol!].isSelected = false;
    }

    selectedRow = r;
    selectedCol = c;
    allCells[r][c].isSelected = true;

    // Highlight row, col, and box
    _updateHighlights(r, c);
  }

  void _updateHighlights(int r, int c) {
    for (int i = 0; i < 9; i++) {
      for (int j = 0; j < 9; j++) {
        allCells[i][j].isHighlighted =
            (i == r || j == c || (i ~/ 3 == r ~/ 3 && j ~/ 3 == c ~/ 3));
      }
    }
  }

  void updateSelectedCellValue(int value) {
    if (selectedRow != null && selectedCol != null) {
      final cell = allCells[selectedRow!][selectedCol!];
      if (!cell.isInitial) {
        cell.updateValue(value);
        cell.isError =
            value != 0 && value != solution[selectedRow!][selectedCol!];
      }
    }
  }
}
