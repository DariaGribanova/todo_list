import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:todo_list/pages/todo_list_page.dart';

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFFFF9900),
          primary: const Color(0xFFFF9900),
          background: const Color(0xFFEDEDED),
          surface: Colors.white,
        ),
        textTheme: TextTheme(
          headlineSmall: GoogleFonts.montserrat(
            fontSize: 24,
            height: 32 / 24,
            fontWeight: FontWeight.bold,
          ),
          bodyLarge: GoogleFonts.montserrat(
            fontSize: 16,
            height: 20 / 16,
          ),
          bodyMedium: GoogleFonts.montserrat(
            fontSize: 14,
            height: 20 / 14,
          ),
        ),
      ),
      home: const TodoListPage(),
    );
  }
}
