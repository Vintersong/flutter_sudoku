import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_sudoku/core/sudoku.dart';

void main() {
  group('SudokuEngine Tests', () {
    test('generatePuzzle creates a valid 9x9 grid', () {
      final grid = SudokuEngine.generatePuzzle();
      expect(grid.length, 9);
      expect(grid[0].length, 9);
    });

    test('isValid correctly identifies valid moves', () {
      List<List<int>> grid = List.generate(9, (_) => List.filled(9, 0));
      expect(SudokuEngine.isValid(grid, 0, 0, 5), true);

      grid[0][1] = 5;
      expect(SudokuEngine.isValid(grid, 0, 0, 5), false); // Same row

      grid[0][1] = 0;
      grid[1][0] = 5;
      expect(SudokuEngine.isValid(grid, 0, 0, 5), false); // Same column

      grid[1][0] = 0;
      grid[1][1] = 5;
      expect(SudokuEngine.isValid(grid, 0, 0, 5), false); // Same box
    });

    test('solve completes a puzzle', () {
      final grid = SudokuEngine.generatePuzzle(difficulty: 0.1);
      final solved = SudokuEngine.solve(grid);
      expect(solved, true);
      expect(SudokuEngine.isComplete(grid), true);
    });
  });
}
