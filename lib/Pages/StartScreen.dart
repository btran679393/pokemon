import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:pokemon/Pages/load_or_new_game.dart';
import 'package:pokemon/Button.dart'; // Uses your circular ControlButton

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});

  void _startGame(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final hasJwt = prefs.containsKey('jwt');

    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const LoadOrNewGame()),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Top half background image
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: screenHeight * 0.5,
            child: Image.asset(
              'assets/StartScreen.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text(
                  'Missing StartScreen.jpg',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),
          ),

          // D-pad (bottom-left)
          Positioned(
            bottom: 100,
            left: 30,
            child: Column(
              children: [
                ControlButton(label: '', onPressed: () {}), // Up
                Row(
                  children: [
                    ControlButton(label: '', onPressed: () {}), // Left
                    const SizedBox(width: 40),
                    ControlButton(label: '', onPressed: () {}), // Right
                  ],
                ),
                ControlButton(label: '', onPressed: () {}), // Down
              ],
            ),
          ),

          // A/B buttons - diagonal with proper spacing
          Positioned(
            bottom: 100,
            right: 40,
            child: SizedBox(
              width: 160,
              height: 160,
              child: Stack(
                children: [
                  // A button (top-right corner)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: ControlButton(
                      label: 'A',
                      onPressed: () => _startGame(context),
                    ),
                  ),
                  // B button (lower-left corner, spaced out)
                  Positioned(
                    bottom: 10,
                    left: 10,
                    child: ControlButton(
                      label: 'B',
                      onPressed: () => _startGame(context),
                    ),
                  ),
                ],
              ),
            ),
          ),




          // Tap to Start text (bottom center)
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: Text(
                'Tap A or B to Start',
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.white.withOpacity(0.95),
                  fontWeight: FontWeight.bold,
                  shadows: const [Shadow(blurRadius: 2, color: Colors.black)],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
