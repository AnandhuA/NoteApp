import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:noteapp/bloc/note_bloc.dart';

import 'package:noteapp/screens/home_screen.dart';
import 'package:noteapp/theme/theme_bloc/theme_bloc.dart';
import 'package:noteapp/ui_change_bloc/ui_change_bloc.dart';

bool isdarkMode = false;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => NoteBloc()),
        BlocProvider(create: (context) => ThemeBloc()),
        BlocProvider(create: (context) => UiChangeBloc())
      ],
      child: BlocBuilder<ThemeBloc, ThemeState>(
        builder: (context, state) {
          if (state is ThemeInitial) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: const HomeScreen(),
              theme: state.themeData,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
