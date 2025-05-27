import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:pokemon/button.dart';
import 'package:pokemon/Pages/RivalBattle1.dart';
import 'package:pokemon/game_state.dart';

class PalletTown extends StatefulWidget {
  const PalletTown({super.key});

  @override
  State<PalletTown> createState() => _PalletTownState();
}

class _PalletTownState extends State<PalletTown> {
  double characterX = 160;
  double characterY = 250;

  final double rivalX = 160;
  final double rivalY = 40;

  bool hasTalkedToRival = false;

  void moveCharacter(String direction) {
    setState(() {
      const double step = 10;

      switch (direction) {
        case 'up':
          characterY -= step;
          break;
        case 'down':
          characterY += step;
          break;
        case 'left':
          characterX -= step;
          break;
        case 'right':
          characterX += step;
          break;
      }

      // Trigger rival battle only if Garry hasn't been defeated
      if (!GameState.hasBattledGarry &&
          !hasTalkedToRival &&
          (characterX - rivalX).abs() < 30 &&
          (characterY - rivalY).abs() < 30) {
        hasTalkedToRival = true;
        Future.delayed(Duration.zero, () {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text("Rival"),
              content: const Text(
                "You again? You’ll never be as good as me.\nI was born to win!",
                style: TextStyle(fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const RivalBattle1(playerName: ''),
                      ),
                    );
                  },
                  child: const Text("Bring it on!"),
                ),
              ],
            ),
          );
        });
      }
    });
  }

  void _openMenuDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Menu"),
        content: const Text("Choose an option below:"),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Close"),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context); // close menu
              _showSaveDialog();
            },
            child: const Text("Save Game"),
          ),
        ],
      ),
    );
  }

  void _showSaveDialog() {
    final TextEditingController _passwordController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Create Password"),
        content: TextField(
          controller: _passwordController,
          obscureText: true,
          decoration: const InputDecoration(
              hintText: "Enter a password to save your game"),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              final password = _passwordController.text.trim();
              final username = "player"; // Replace with actual player name if needed

              if (password.isNotEmpty) {
                await _registerUser(username, password);
                Navigator.pop(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Game saved successfully!")),
                );
              }
            },
            child: const Text("Save"),
          ),
        ],
      ),
    );
  }

  Future<void> _registerUser(String username, String password) async {
    final response = await http.post(
      Uri.parse('http://10.0.2.2:5000/api/auth/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'username': username, 'password': password}),
    );

    if (response.statusCode != 200) {
      print('Failed to save: ${response.body}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background
          Positioned.fill(
            child: Image.asset(
              'assets/palletTown.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Conditionally show Garry
          if (!GameState.hasBattledGarry)
            Positioned(
              left: rivalX,
              top: rivalY,
              child: Image.asset(
                'assets/RivalSprite.jpg',
                width: 40,
                height: 40,
              ),
            ),

          // Player sprite
          Positioned(
            left: characterX,
            top: characterY,
            child: Image.asset(
              'assets/playerSprite.jpg',
              width: 40,
              height: 40,
            ),
          ),

          // GameBoy-style buttons
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.20,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    ControlButton(label: '', onPressed: () => moveCharacter('up')),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        ControlButton(label: '', onPressed: () => moveCharacter('left')),
                        const SizedBox(width: 40),
                        ControlButton(label: '', onPressed: () => moveCharacter('right')),
                      ],
                    ),
                    ControlButton(label: '', onPressed: () => moveCharacter('down')),
                  ],
                ),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Transform.translate(
                      offset: const Offset(30, 0),
                      child: ControlButton(label: 'A', onPressed: () {}),
                    ),
                    Transform.translate(
                      offset: const Offset(-30, 40),
                      child: ControlButton(label: 'B', onPressed: () {}),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Location text
          const Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: EdgeInsets.only(bottom: 40),
              child: Text(
                "You have entered Pallet Town!",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ),

          // Floating menu button (after Garry is defeated)
          if (GameState.hasBattledGarry)
            Positioned(
              top: 16,
              right: 16,
              child: GestureDetector(
                onTap: _openMenuDialog,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.9),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        blurRadius: 4,
                        offset: const Offset(2, 2),
                      ),
                    ],
                  ),
                  child: const Icon(Icons.menu, color: Colors.black),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
