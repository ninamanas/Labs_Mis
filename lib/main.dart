// lib/main.dart
import 'package:flutter/material.dart';
import 'screens/exam_list_screen.dart';

void main() {
  runApp(const ExamApp());
}

class ExamApp extends StatelessWidget {
  const ExamApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Распоред за испити',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home: ExamListScreen(),
    );
  }
}