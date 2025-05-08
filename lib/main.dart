import 'package:flutter/material.dart';
import 'Pages/home_page.dart';           // HomePage widget
import 'Pages/StartScreen.dart';        // BootScreen widget

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pokemon Boot Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      home: const BootScreen(),  // Starts with the boot screen
    );
  }
}
