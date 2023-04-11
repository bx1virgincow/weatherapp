import 'package:flutter/material.dart';

class BasicScreen extends StatelessWidget {
  const BasicScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.green,
      child: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Container(
          color: Colors.purple,
          child: Padding(
            padding: const EdgeInsets.all(50.0),
            child: _buildShinyCircle(),
          ),
        ),
      ),
    );
  }
}

//building a shiny circle
Widget _buildShinyCircle() {
  return Container(
    decoration: const BoxDecoration(
        shape: BoxShape.circle,
        gradient: RadialGradient(
            colors: [Colors.white, Colors.green],
            center: Alignment(-0.3, -0.5)),
        boxShadow: [BoxShadow(blurRadius: 20)]),
  );
}
