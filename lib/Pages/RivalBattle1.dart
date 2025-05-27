import 'package:flutter/material.dart';
import 'rival_cutscene.dart'; // make sure this file exists

class RivalBattle1 extends StatefulWidget {
  const RivalBattle1({super.key, required String playerName});

  @override
  State<RivalBattle1> createState() => _RivalBattle1State();
}

class _RivalBattle1State extends State<RivalBattle1> {
  int charmanderHP = 20;
  int squirtleHP = 20;
  int turnCount = 0;
  bool battleOver = false;
  String message = "What will CHARMANDER do?";

  void userTurn(int damage) {
    if (battleOver || turnCount >= 3) return;

    setState(() {
      turnCount++;
      squirtleHP -= damage;

      if (squirtleHP <= 0 || turnCount == 3) {
        squirtleHP = 0;
        message = "Squirtle fainted! You win!";
        battleOver = true;

        // Delay then go to cutscene
        Future.delayed(Duration(seconds: 2), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const RivalCutscene()),
          );
        });

        return;
      }

      int rivalDamage = turnCount == 1 ? 6 : (turnCount == 2 ? 7 : 8);
      charmanderHP -= rivalDamage;
      if (charmanderHP < 0) charmanderHP = 0;

      message = "Squirtle countered! Your HP: $charmanderHP";
    });
  }

  Widget healthBar(String name, int hp) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('$name - HP: $hp/20',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        LinearProgressIndicator(
          value: hp / 20,
          minHeight: 8,
          backgroundColor: Colors.red[200],
          valueColor: const AlwaysStoppedAnimation<Color>(Colors.green),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Positioned.fill(
                  child: Image.asset(
                    'assets/BattleBackGround.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 16,
                  right: 16,
                  child: healthBar("Squirtle", squirtleHP),
                ),
                Positioned(
                  top: 90,
                  right: 150,
                  child: Image.asset('assets/Squirtle.png', height: 100),
                ),
                Positioned(
                  bottom: 130,
                  left: 16,
                  right: 16,
                  child: healthBar("Charmander", charmanderHP),
                ),
                Positioned(
                  bottom: 250,
                  left: 120,
                  child: Image.asset('assets/Charmander.png', height: 100),
                ),
              ],
            ),
          ),
          Container(
            color: Colors.grey[200]?.withOpacity(0.9),
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(message, style: const TextStyle(fontSize: 18)),
                const SizedBox(height: 10),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    ElevatedButton(
                      onPressed: (!battleOver && turnCount < 3)
                          ? () => userTurn(6)
                          : null,
                      child: const Text("EMBER"),
                    ),
                    ElevatedButton(
                      onPressed: (!battleOver && turnCount < 3)
                          ? () => userTurn(4)
                          : null,
                      child: const Text("SCRATCH"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("BAG"),
                    ),
                    ElevatedButton(
                      onPressed: () {},
                      child: const Text("RUN"),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
