import 'package:flutter/material.dart';

import '../data/courses.dart';
import '../theme.dart';
import '../widgets.dart';
import 'home_screen.dart';

class CoursesScreen extends StatefulWidget {
  const CoursesScreen({super.key});
  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  String category = 'All';
  String query = '';

  @override
  Widget build(BuildContext context) {
    final q = query.toLowerCase();
    final list = courses.where((c) {
      final catOk = category == 'All' || c.category == category;
      final qOk =
          q.isEmpty ||
          c.title.toLowerCase().contains(q) ||
          c.description.toLowerCase().contains(q) ||
          c.lessons.any((l) => l.title.toLowerCase().contains(q));
      return catOk && qOk;
    }).toList();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
        children: [
          const Text(
            'All courses',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 4),
          MonoText(
            '${courses.length} courses · '
            '${courses.fold<int>(0, (s, c) => s + c.lessons.length)} lessons',
          ),
          const SizedBox(height: 14),
          Container(
            decoration: BoxDecoration(
              color: BB.card,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: BB.ink, width: 2),
            ),
            child: TextField(
              onChanged: (v) => setState(() => query = v),
              decoration: const InputDecoration(
                hintText: 'Search F&O, SIP, RSI, IPO…',
                prefixIcon: Icon(Icons.search, color: BB.ink),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(vertical: 14),
              ),
            ),
          ),
          const SizedBox(height: 14),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final cat in categories)
                Pill(
                  cat,
                  selected: cat == category,
                  onTap: () =>
                      setState(() => category = cat == category ? 'All' : cat),
                ),
            ],
          ),
          const SizedBox(height: 18),
          if (list.isEmpty)
            const Padding(
              padding: EdgeInsets.all(30),
              child: Center(child: Text('No courses match your search.')),
            ),
          for (final c in list)
            CourseTile(c, onTap: () => openCourse(context, c)),
        ],
      ),
    );
  }
}
