import 'package:flutter/material.dart';
import 'professor_office.dart'; // Next screen

class ProfessorIntro extends StatelessWidget {
  final String playerName;

  const ProfessorIntro({super.key, required this.playerName});

  void _goToNext(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => ProfessorOffice(
          playerName: playerName,
          starterPokemon: 'Charmander', // TODO: replace with actual selection later
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Professor Dan image
            SizedBox(
              height: screenHeight * 0.5,
              width: double.infinity,
              child: Image.asset(
                'assets/professorDan.jpg',
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => const Center(
                  child: Text(
                    'Missing: professorDan.jpg',
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    "Hello there, $playerName!\nWelcome to the world of Pokémon!\nI'm Professor Dan.",
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () => _goToNext(context),
                    child: const Text("Next"),
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
