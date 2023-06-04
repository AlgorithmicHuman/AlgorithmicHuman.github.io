import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:islamify_admin/screens/course_creation_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Islamify Admin',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0070BB),
        ),
        textTheme: GoogleFonts.openSansTextTheme(),
        useMaterial3: true,
      ),
      home: const CourseCreationScreen(),
    );
  }
}
