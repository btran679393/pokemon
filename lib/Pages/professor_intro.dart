import 'package:flutter/material.dart';
import '../choose_pokemon.dart';

class ProfessorIntro extends StatefulWidget {
  const ProfessorIntro({super.key});

  @override
  State<ProfessorIntro> createState() => _ProfessorIntroState();
}

class _ProfessorIntroState extends State<ProfessorIntro> {
  final TextEditingController _nameController = TextEditingController();

  void _goToChoosePokemon() {
    final name = _nameController.text.trim();
    if (name.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ChoosePokemon(playerName: name),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            // 🧪 Professor Dan image fills top half
            SizedBox(
              height: screenHeight * 0.5,
              width: double.infinity,
              child: Image.asset(
                'Assets/professorDan.jpg',
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  const Text(
                    "Hello there! Welcome to the world of Pokémon!\nI'm Professor Dan.\nWhat is your name?",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      hintText: "Enter your name",
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _goToChoosePokemon,
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
