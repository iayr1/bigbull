import 'package:flutter/material.dart';

import '../data/courses.dart';
import '../progress.dart';
import '../theme.dart';
import '../widgets.dart';
import 'course_screen.dart';

void openCourse(BuildContext context, Course c) {
  Progress.of(context).open(c);
  Navigator.of(
    context,
  ).push(MaterialPageRoute(builder: (_) => CourseScreen(course: c)));
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String category = 'All';

  @override
  Widget build(BuildContext context) {
    final p = Progress.of(context);
    final current = p.lastCourse ?? courses.first;
    final recommended = courses.firstWhere(
      (c) => c.id != current.id && p.doneCount(c) < c.lessons.length,
      orElse: () => courses[1],
    );
    final list = category == 'All'
        ? courses
        : courses.where((c) => c.category == category).toList();

    return SafeArea(
      bottom: false,
      child: ListView(
        padding: const EdgeInsets.fromLTRB(18, 8, 18, 24),
        children: [
          const _Header(),
          const SectionTitle('Continue learning'),
          _ContinueCard(course: current),
          const SectionTitle('Recommended'),
          _RecommendedCard(course: recommended),
          const SectionTitle('Browse courses'),
          SizedBox(
            height: 36,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              clipBehavior: Clip.none,
              itemCount: categories.length,
              separatorBuilder: (_, _) => const SizedBox(width: 8),
              itemBuilder: (_, i) => Pill(
                categories[i],
                selected: categories[i] == category,
                onTap: () => setState(
                  () => category = categories[i] == category
                      ? 'All'
                      : categories[i],
                ),
              ),
            ),
          ),
          const SizedBox(height: 14),
          for (final c in list)
            CourseTile(c, onTap: () => openCourse(context, c)),
        ],
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(
            color: BB.green,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(color: BB.ink, width: 2),
            boxShadow: const [BoxShadow(color: BB.ink, offset: Offset(2, 2))],
          ),
          child: const Text(
            '🐂 Bigbull',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w900,
              fontSize: 16,
            ),
          ),
        ),
        const Expanded(
          child: Text(
            'Learn Market',
            textAlign: TextAlign.center,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(fontWeight: FontWeight.w800, fontSize: 16),
          ),
        ),
        Container(
          width: 38,
          height: 38,
          decoration: BoxDecoration(
            color: BB.card,
            shape: BoxShape.circle,
            border: Border.all(color: BB.ink, width: 2),
          ),
          child: const Icon(Icons.notifications_none, size: 20),
        ),
      ],
    );
  }
}

class _ContinueCard extends StatelessWidget {
  final Course course;
  const _ContinueCard({required this.course});

  @override
  Widget build(BuildContext context) {
    final p = Progress.of(context);
    final done = p.doneCount(course);
    final pct = (p.fraction(course) * 100).round();
    return BoxCard(
      onTap: () => openCourse(context, course),
      child: Row(
        children: [
          Mascot(course, size: 56),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    MonoText(
                      '$done/${course.lessons.length} Lessons',
                      size: 11,
                    ),
                    const Spacer(),
                    MonoText('$pct%', size: 11),
                  ],
                ),
                const SizedBox(height: 4),
                BBProgressBar(p.fraction(course)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _RecommendedCard extends StatelessWidget {
  final Course course;
  const _RecommendedCard({required this.course});

  @override
  Widget build(BuildContext context) {
    return BoxCard(
      onTap: () => openCourse(context, course),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Mascot(course, size: 60),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course.title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 17,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'You will learn: ${course.description}',
                  style: const TextStyle(fontSize: 13, height: 1.35),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    MonoText(
                      '${course.lessons.length} lessons · ${course.totalMinutes} min',
                      size: 11,
                    ),
                    const Spacer(),
                    const Icon(Icons.arrow_forward, size: 18),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
