import 'package:flutter/material.dart';
import 'choose_pokemon.dart';
import 'login.dart'; // new login screen
import 'PalletTown.dart';

class LoadOrNewGame extends StatelessWidget {
  const LoadOrNewGame({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const ChoosePokemon()),
                );
              },
              child: const Text('Start New Game'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                );
              },
              child: const Text('Load Saved Game'),
            ),
          ],
        ),
      ),
    );
  }
}
