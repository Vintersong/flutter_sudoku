import 'dart:math';

class SudokuEngine {
  static const int size = 9;
  static const int boxSize = 3;

  /// Generates a new Sudoku puzzle with a given [difficulty].
  /// [difficulty] ranges from 0 (easy) to 1 (hard).
  static List<List<int>> generatePuzzle({double difficulty = 0.5}) {
    List<List<int>> grid = List.generate(size, (_) => List.filled(size, 0));
    _fillGrid(grid);

    // Remove numbers based on difficulty
    int cellsToRemove = (size * size * (0.4 + difficulty * 0.4)).toInt();
    _removeNumbers(grid, cellsToRemove);

    return grid;
  }

  static bool _fillGrid(List<List<int>> grid) {
    for (int row = 0; row < size; row++) {
      for (int col = 0; col < size; col++) {
        if (grid[row][col] == 0) {
          List<int> numbers = List.generate(size, (i) => i + 1)..shuffle();
          for (int num in numbers) {
            if (isValid(grid, row, col, num)) {
              grid[row][col] = num;
              if (_fillGrid(grid)) return true;
              grid[row][col] = 0;
            }
          }
          return false;
        }
      }
    }
    return true;
  }

  static void _removeNumbers(List<List<int>> grid, int count) {
    Random random = Random();
    int removed = 0;
    while (removed < count) {
      int row = random.nextInt(size);
      int col = random.nextInt(size);
      if (grid[row][col] != 0) {
        grid[row][col] = 0;
        removed++;
      }
    }
  }

  static bool isValid(List<List<int>> grid, int row, int col, int num) {
    // Check row
    for (int x = 0; x < size; x++) {
      if (grid[row][x] == num) return false;
    }

    // Check column
    for (int x = 0; x < size; x++) {
      if (grid[x][col] == num) return false;
    }

    // Check 3x3 box
    int startRow = row - row % boxSize;
    int startCol = col - col % boxSize;
    for (int i = 0; i < boxSize; i++) {
      for (int j = 0; j < boxSize; j++) {
        if (grid[i + startRow][j + startCol] == num) return false;
      }
    }

    return true;
  }

  static bool solve(List<List<int>> grid) {
    return _fillGrid(grid);
  }

  static bool isComplete(List<List<int>> grid) {
    for (var row in grid) {
      if (row.contains(0)) return false;
    }
    return true;
  }
}
