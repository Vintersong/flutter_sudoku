# 🏗 Architecture Guide: Neural Grid

Neural Grid is built on three main pillars: **Performance**, **Scalability**, and **Cyberpunk Aesthetics**.

## 1. Sudoku Engine (`lib/core/sudoku.dart`)
The core logic is a pure Dart implementation of Sudoku algorithms.
- **Puzzle Generator**: Uses a backtracking solver to ensure every generated puzzle has a unique solution.
- **Difficulty Scaling**: Controls the number of filled cells to adjust the challenge level.
- **Validation**: Efficiently checks Sudoku rules across rows, columns, and 3x3 blocks.

## 2. Flame Game Layer (`lib/game/`)
We use the **Flame Game Engine** for rendering because of its optimized component system and easy handling of low-level graphics (like glows and particles).

### Component Hierarchy:
- **`SudokuGame`**: The main game controller. It manages the camera, scaling, and high-level input.
- **`SudokuBlock`**: A 3x3 container of cells. This modular unit handles local borders and sub-grid logic.
- **`CellComponent`**: The atomic unit. Handles its own rendering state (selected, highlighted, error) and tap events.

## 3. UI Layer (Flutter Widgets)
Flutter-native widgets are used for components that require precise layout or complex user interaction.
- **`NumberPad`**: Overlays the Flame game to provide a sleek input interface.
- **`LayoutBuilder`**: Used in `GameScreen` to query device dimensions and provide a perfectly-sized viewport for the Flame engine.

## 4. State Management
The app uses a **Component-Callback pattern**:
1. `CellComponent` captures a tap.
2. It executes a callback passed down from `SudokuGame`.
3. `SudokuGame` updates the global selection state.
4. `SudokuBlock` and `CellComponent` update their visual representation during the next frame tick.

---

For more details, see the [README.md](./README.md).
