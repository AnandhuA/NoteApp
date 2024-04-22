import 'package:flutter/material.dart';
import 'package:noteapp/api/api.dart';
import 'package:noteapp/screens/home_screen.dart';

void main() async {
  await getAllNotes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}
