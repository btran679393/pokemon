import 'package:flutter/material.dart';
import 'professor_intro.dart'; // 👈 Import your new screen

class BootScreen extends StatelessWidget {
  const BootScreen({super.key});

  void _goToProfessorIntro(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const ProfessorIntro()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _goToProfessorIntro(context),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            // Background image
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: MediaQuery.of(context).size.height * 0.4,
              child: Image.asset(
                'Assets/StartScreen.jpg',
                fit: BoxFit.cover,
              ),
            ),

            // "Tap to Continue" text
            Positioned(
              top: MediaQuery.of(context).size.height * 0.35,
              left: 0,
              right: 0,
              child: const Center(
                child: Text(
                  'Tap to Continue',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    shadows: [
                      Shadow(blurRadius: 10, color: Colors.black, offset: Offset(2, 2)),
                    ],
                  ),
                ),
              ),
            ),

            // D-pad + A/B buttons
            Positioned(
              bottom: MediaQuery.of(context).size.height * 0.20,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  // D-pad
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _ControlButton(label: '↑', onPressed: () => print('Up')),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          _ControlButton(label: '←', onPressed: () => print('Left')),
                          const SizedBox(width: 40),
                          _ControlButton(label: '→', onPressed: () => print('Right')),
                        ],
                      ),
                      _ControlButton(label: '↓', onPressed: () => print('Down')),
                    ],
                  ),

                  // A/B buttons
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Transform.translate(
                        offset: const Offset(30, 0),
                        child: _ControlButton(
                          label: 'A',
                          onPressed: () => _goToProfessorIntro(context),
                        ),
                      ),
                      Transform.translate(
                        offset: const Offset(-30, 40),
                        child: _ControlButton(
                          label: 'B',
                          onPressed: () => _goToProfessorIntro(context),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 🎮 GameBoy-style button
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
