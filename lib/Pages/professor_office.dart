import 'package:flutter/material.dart';
import 'PalletTown.dart';

class ProfessorOffice extends StatefulWidget {
  final String playerName;
  final String starterPokemon;

  const ProfessorOffice({
    super.key,
    required this.playerName,
    required this.starterPokemon,
  });

  @override
  State<ProfessorOffice> createState() => _ProfessorOfficeState();
}

class _ProfessorOfficeState extends State<ProfessorOffice> {
  int _currentLine = 0;

  late final List<String> _dialogue = [
    "Welcome, ${widget.playerName}! I see you chose ${widget.starterPokemon}!",
    "Your journey now begins in the Kanto region.",
    "Your goal is to become the best trainer in the region.",
    "To do that, you’ll need to travel across Kanto, battle fierce opponents, and collect 8 Gym Badges.",
    "Each badge is earned by defeating a powerful Gym Leader.",
    "They won't go down easy — you’ll need strategy, strength, and determination.",
    "Now, step forward and begin your adventure!",
  ];

  void _nextLine() {
    if (_currentLine < _dialogue.length - 1) {
      setState(() {
        _currentLine++;
      });
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const PalletTown()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: _nextLine,
        child: Stack(
          fit: StackFit.expand,
          children: [
            // Background
            Image.asset(
              'assets/professorOffice.jpg',
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) => const Center(
                child: Text(
                  'Missing: professorOffice.jpg',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),

            // Positioned Professor Dan (where Pokéballs are)
            Positioned(
              top: 160, // adjust as needed
              left: MediaQuery.of(context).size.width / 2 - 80, // center horizontally
              child: Image.asset(
                'assets/professorDan.jpg',
                height: 160,
                errorBuilder: (context, error, stackTrace) => const Text(
                  'Missing: professorDan.jpg',
                  style: TextStyle(color: Colors.red),
                ),
              ),
            ),

            // Dialogue box at the bottom
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                color: Colors.white.withOpacity(0.85),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _dialogue[_currentLine],
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      "Tap anywhere to continue...",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
