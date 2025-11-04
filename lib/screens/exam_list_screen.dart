// lib/screens/exam_list_screen.dart
import 'package:flutter/material.dart';
import '../models/exam.dart';
import '../widgets/exam_card.dart';
import 'exam_detail_screen.dart';

class ExamListScreen extends StatelessWidget {
  ExamListScreen({super.key});

  final List<Exam> exams = [
    Exam(subjectName: "Структурно програмирање", dateTime: DateTime(2025, 10, 10, 9, 0), rooms: ["Lab 13"]),
    Exam(subjectName: "Дискретна математика", dateTime: DateTime(2025, 11, 12, 10, 0), rooms: ["128"]),
    Exam(subjectName: "Архитектура и организација на компјутери", dateTime: DateTime(2025, 11, 15, 9, 30), rooms: ["213"]),
    Exam(subjectName: "Алгоритми и податочни структури", dateTime: DateTime(2025, 11, 18, 12, 0), rooms: ["Lab 12"]),
    Exam(subjectName: "Оперативни системи", dateTime: DateTime(2025, 11, 22, 10, 0), rooms: ["128"]),
    Exam(subjectName: "Бази на податоци", dateTime: DateTime(2025, 10, 25, 8, 30), rooms: ["AB13"]),
    Exam(subjectName: "Компјутерски мрежи", dateTime: DateTime(2025, 11, 28, 11, 0), rooms: ["B13"]),
    Exam(subjectName: "Веб програмирање", dateTime: DateTime(2025, 12, 1, 9, 0), rooms: ["Lab 1"]),
    Exam(subjectName: "Софтверско инженерство", dateTime: DateTime(2025, 12, 5, 10, 30), rooms: ["128"]),
    Exam(subjectName: "Бизнис и менаџмент", dateTime: DateTime(2025, 12, 10, 9, 0), rooms: ["Lab 12"]),
  ];

  @override
  Widget build(BuildContext context) {
    exams.sort((a, b) => a.dateTime.compareTo(b.dateTime));

    return Scaffold(
      appBar: AppBar(
        title: const Text("Распоред за испити - 223105"),
        backgroundColor: Colors.blueAccent,
      ),
      body: ListView.builder(
        itemCount: exams.length,
        itemBuilder: (context, index) {
          final exam = exams[index];
          return ExamCard(
            exam: exam,
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ExamDetailScreen(exam: exam),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(12),
        color: Colors.blueAccent,
        child: Text(
          "Вкупно испити: ${exams.length}",
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}
