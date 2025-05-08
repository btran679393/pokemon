import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BootScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
  // ... your existing BootScreen code ...
}

// 👇 Add this directly below BootScreen (outside it)
class _ControlButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;

  const _ControlButton({required this.label, required this.onPressed});

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
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }
}
