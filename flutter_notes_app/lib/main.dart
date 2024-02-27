import 'package:flutter/material.dart';
import 'package:flutter_notes_app/homePage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        // Uncomment the comment below if you want to remove the debug banner
        // debugShowCheckedModeBanner: false,
        home: homePage());
  }
}
