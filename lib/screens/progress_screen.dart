import 'package:flutter/material.dart';

import '../data/courses.dart';
import '../progress.dart';
import '../theme.dart';
import '../widgets.dart';
import 'home_screen.dart';

class ProgressScreen extends StatelessWidget {
  const ProgressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final p = Progress.of(context);
    final totalLessons = courses.fold<int>(0, (s, c) => s + c.lessons.length);
    var minutes = 0;
    for (final c in courses) {
      for (var i = 0; i < c.lessons.length; i++) {
        if (p.isDone(c, i))
          minutes += int.parse(c.lessons[i].duration.split(':')[0]) + 1;
      }
    }
    final started = courses.where((c) => p.doneCount(c) > 0).toList();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 14, 18, 24),
        children: [
          const Text(
            'My progress',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
              letterSpacing: -0.8,
            ),
          ),
          const SizedBox(height: 16),
          BoxCard(
            color: BB.green,
            padding: const EdgeInsets.all(18),
            child: Row(
              children: [
                const Text('🐂', style: TextStyle(fontSize: 44)),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _rank(p.totalDone),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.w900,
                        ),
                      ),
                      const SizedBox(height: 6),
                      BBProgressBar(p.totalDone / totalLessons),
                      const SizedBox(height: 4),
                      MonoText(
                        '${p.totalDone}/$totalLessons lessons overall',
                        size: 11,
                        color: Colors.white,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 14),
          Row(
            children: [
              _Stat('${p.totalDone}', 'Lessons', BB.yellow),
              const SizedBox(width: 10),
              _Stat('${p.coursesCompleted}', 'Courses', BB.lavender),
              const SizedBox(width: 10),
              _Stat('$minutes', 'Minutes', const Color(0xFFFFB86B)),
            ],
          ),
          const SectionTitle('Courses in progress'),
          if (started.isEmpty)
            BoxCard(
              child: Column(
                children: [
                  const Text(
                    'Nothing here yet 👀',
                    style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Complete your first lesson to start tracking progress.',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 14),
                  YellowButton(
                    label: 'Start Stock Market Basics',
                    onTap: () => openCourse(context, courses.first),
                  ),
                ],
              ),
            ),
          for (final c in started)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: BoxCard(
                onTap: () => openCourse(context, c),
                child: Row(
                  children: [
                    Mascot(c, size: 42),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            c.title,
                            style: const TextStyle(fontWeight: FontWeight.w800),
                          ),
                          const SizedBox(height: 6),
                          BBProgressBar(p.fraction(c)),
                          const SizedBox(height: 4),
                          MonoText(
                            '${p.doneCount(c)}/${c.lessons.length} Lessons',
                            size: 11,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _rank(int n) {
    if (n >= 60) return 'Market Master';
    if (n >= 30) return 'Bull Rider';
    if (n >= 10) return 'Smart Investor';
    if (n >= 1) return 'Rising Calf';
    return 'New Learner';
  }
}

class _Stat extends StatelessWidget {
  final String value;
  final String label;
  final Color color;
  const _Stat(this.value, this.label, this.color);

  @override
  Widget build(BuildContext context) => Expanded(
    child: BoxCard(
      color: color,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Column(
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900),
          ),
          MonoText(label, size: 11),
        ],
      ),
    ),
  );
}
