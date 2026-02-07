# 🌌 Neural Grid: Cyberpunk Sudoku

![Banner](https://via.placeholder.com/1000x300?text=NEURAL+GRID+SUDOKU)

**Neural Grid** is a visually stunning, high-performance Sudoku application designed with a distinct cyberpunk aesthetic. It leverages the **Flame Game Engine** to deliver smooth animations and glow effects while maintaining the accessibility of a standard Flutter app.

## ⚡ Quick Start

1. **Install Flutter**: Ensure you have Flutter installed and configured.
2. **Clone & Explore**:
   ```bash
   git clone https://github.com/user/neural-grid.git
   cd neural-grid
   ```
3. **Download Dependencies**:
   ```bash
   flutter pub get
   ```
4. **Run the Hack**:
   ```bash
   flutter run -d windows # Or your preferred device
   ```

## 🛠 Features

- **Neon Aesthetics**: A dark, glowing theme inspired by synthwave aesthetics.
- **Flame Integration**: Pixel-perfect grid rendering via custom `PositionComponent`s.
- **Modular Architecture**: Uses a 3x3 block-based component structure for optimal performance and code clarity.
- **Responsive Scaling**: Automatically adapts to any screen size using `LayoutBuilder` and Flame's viewfinder.
- **Neural Engine**: Built-in Sudoku engine for instant puzzle generation and solving.

## 📁 Project Structure

- `lib/core/`: Sudoku logic and theme definitions.
- `lib/game/`: Flame components (`SudokuBlock`, `CellComponent`) and game state.
- `lib/screens/`: Flutter UI screens (Home, Game).
- `lib/widgets/`: Reusable UI components like the number pad.

## 🧪 Development

For technical details on the engine and rendering pipeline, check out the [Architecture Guide](./ARCHITECTURE.md).

---

Built with ❤️ by [Your Name/Handle]
