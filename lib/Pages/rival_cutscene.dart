import 'package:flutter/material.dart';
import '../game_state.dart';
import 'PalletTown.dart';

class RivalCutscene extends StatefulWidget {
  const RivalCutscene({super.key});

  @override
  State<RivalCutscene> createState() => _RivalCutsceneState();
}

class _RivalCutsceneState extends State<RivalCutscene> {
  int dialogueIndex = 0;

  final List<String> dialogue = [
    "Garry: That was a good battle...",
    "Garry: But don’t get comfortable.",
    "Garry: Next time, I’ll be stronger and I’ll beat you!",
    "*Garry runs off*",
  ];

  void nextLine() {
    if (dialogueIndex < dialogue.length - 1) {
      setState(() {
        dialogueIndex++;
      });
    } else {
      GameState.hasBattledGarry = true;
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const PalletTown()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: nextLine,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  dialogue[dialogueIndex],
                  style: const TextStyle(color: Colors.white, fontSize: 22),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                const Text(
                  "Tap to continue...",
                  style: TextStyle(color: Colors.grey, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
