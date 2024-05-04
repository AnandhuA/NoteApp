import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/api/api.dart';
import 'package:noteapp/screens/home/home_screen.dart';
import 'package:noteapp/ui_change_bloc/ui_change_bloc_bloc.dart';

void main() async {

  await getAllNotes();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UiChangeBlocBloc(),
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        home: HomeScreen(),
      ),
    );
  }
}
