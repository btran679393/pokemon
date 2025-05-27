import 'package:flutter/material.dart';

class BootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // You can implement this later
    throw UnimplementedError();
  }
}

// ✅ Now a public widget you can import and reuse
class ControlButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const ControlButton({required this.label, required this.onPressed, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.grey[800],
        ),
        onPressed: onPressed,
        child: Text(label, style: const TextStyle(fontSize: 18, color: Colors.white)),
      ),
    );
  }
}
