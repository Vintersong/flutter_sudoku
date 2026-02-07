import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import '../game/sudoku_game.dart';
import '../core/sudoku.dart';
import '../widgets/number_pad.dart';
import '../core/theme.dart';

class GameScreen extends StatefulWidget {
  final double difficulty;

  const GameScreen({super.key, this.difficulty = 0.5});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  late SudokuGame _game;
  late List<List<int>> _initialGrid;
  late List<List<int>> _solution;

  @override
  void initState() {
    super.initState();
    _startNewGame();
  }

  void _startNewGame() {
    _initialGrid = SudokuEngine.generatePuzzle(difficulty: widget.difficulty);
    // Copy the grid to solve it for the solution
    _solution = List.generate(9, (r) => List.from(_initialGrid[r]));
    SudokuEngine.solve(_solution);

    _game = SudokuGame(initialGrid: _initialGrid, solution: _solution);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('NEURAL GRID'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh, color: CyberpunkTheme.neonPink),
            onPressed: () {
              setState(() {
                _startNewGame();
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                final displaySize = constraints.biggest.shortestSide;
                return Center(
                  child: SizedBox(
                    width: displaySize,
                    height: displaySize,
                    child: GameWidget(game: _game),
                  ),
                );
              },
            ),
          ),
          NumberPad(
            onNumberSelected: (value) {
              _game.updateSelectedCellValue(value);
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
