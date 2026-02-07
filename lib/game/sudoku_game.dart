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
    const double blockSize = cellSize * 3 + gap * 2; // 154
    const double borderExtension = gap; // Borders extend by gap on each side
    const double totalGridSize =
        blockSize * 3 + blockGap * 2 + borderExtension * 2; // 474

    allCells = List.generate(9, (_) => <CellComponent>[]);
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
    // Build the 9x9 grid from blocks
    // We need to iterate in row-major order to build allCells correctly
    for (int globalRow = 0; globalRow < 9; globalRow++) {
      for (int globalCol = 0; globalCol < 9; globalCol++) {
        final blockRow = globalRow ~/ 3;
        final blockCol = globalCol ~/ 3;
        final localRow = globalRow % 3;
        final localCol = globalCol % 3;

        final block = blocks[blockRow * 3 + blockCol];
        allCells[globalRow].add(block.cells[localRow][localCol]);
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
    const double blockGap = 4.0;
    const double blockSize = cellSize * 3 + gap * 2;
    const double borderExtension = gap;
    const double totalGridSize =
        blockSize * 3 + blockGap * 2 + borderExtension * 2;
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
