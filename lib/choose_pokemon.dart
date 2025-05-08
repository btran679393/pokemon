import 'package:flutter/material.dart';

class ChoosePokemon extends StatelessWidget {
  final String playerName;
  const ChoosePokemon({super.key, required this.playerName});

  void _selectPokemon(BuildContext context, String pokemon) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Confirm Your Choice"),
        content: Text("Are you sure you want to choose $pokemon?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancel
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              // Display confirmation message
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("$pokemon has joined your team!")),
              );
              // TODO: Navigate to next screen or store selected Pokémon
            },
            child: const Text("Yes"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text("Welcome, $playerName"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Choose your first Pokémon!",
            style: TextStyle(color: Colors.white, fontSize: 22),
          ),
          const SizedBox(height: 30),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pokemonCard(context, "Bulbasaur", "Assets/Bulbasaur.png"),
                _pokemonCard(context, "Charmander", "Assets/Charmander.png"),
                _pokemonCard(context, "Squirtle", "Assets/Squirtle.png"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _pokemonCard(BuildContext context, String name, String imagePath) {
    return Column(
      children: [
        Image.asset(imagePath, height: 100),
        const SizedBox(height: 8),
        Text(name, style: const TextStyle(color: Colors.white, fontSize: 16)),
        const SizedBox(height: 4),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.deepPurple,
          ),
          onPressed: () => _selectPokemon(context, name),
          child: const Text("Choose"),
        ),
      ],
    );
  }
}