import 'package:flutter/material.dart';

class GridSandboxScreen extends StatelessWidget {
  const GridSandboxScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(3, (row) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (col) {
                return Container(
                  width: 50,
                  height: 50,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    border: Border.all(color: Colors.white, width: 2),
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
