// lib/screens/exam_detail_screen.dart
import 'package:flutter/material.dart';
import '../models/exam.dart';

class ExamDetailScreen extends StatelessWidget {
  final Exam exam;

  const ExamDetailScreen({super.key, required this.exam});

  String _timeUntilExam() {
    final now = DateTime.now();
    final diff = exam.dateTime.difference(now);
    if (diff.isNegative) return "Испитот е завршен.";
    final days = diff.inDays;
    final hours = diff.inHours.remainder(24);
    return "$days дена, $hours часа";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(exam.subjectName),
        backgroundColor: Colors.yellowAccent[100],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Предмет: ${exam.subjectName}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, color: Colors.yellow),
                const SizedBox(width: 8),
                Text(
                  "Датум: ${exam.dateTime.day}.${exam.dateTime.month}.${exam.dateTime.year}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.access_time, color: Colors.yellow),
                const SizedBox(width: 8),
                Text(
                  "Време: ${exam.dateTime.hour.toString().padLeft(2, '0')}:${exam.dateTime.minute.toString().padLeft(2, '0')}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.location_on, color: Colors.yellow),
                const SizedBox(width: 8),
                Text(
                  "Простории: ${exam.rooms.join(', ')}",
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              "Преостанато време: ${_timeUntilExam()}",
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
