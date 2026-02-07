import 'package:flutter/material.dart';

class GridSandboxScreen extends StatelessWidget {
  const GridSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          spacing: 2,
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(9, (row) {
            return Row(
              spacing: 2,
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(9, (col) {
                return Container(
                  width: 44,
                  height: 44,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(25, 255, 251, 10),
                    border: Border.all(
                      color: const Color.fromARGB(255, 240, 0, 60),
                      width: 1.5,
                    ),
                  ),
                );
              }),
            );
          }),
        ),
      ),
    );
  }
}
