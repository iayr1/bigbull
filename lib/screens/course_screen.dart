import 'package:flutter/material.dart';

import '../data/courses.dart';
import '../progress.dart';
import '../theme.dart';
import '../widgets.dart';
import 'lesson_screen.dart';

class BBAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  const BBAppBar(this.title, {super.key});

  @override
  Size get preferredSize => const Size.fromHeight(56);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: BB.cream,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => Navigator.of(context).maybePop(),
      ),
      title: Text(
        title,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
      ),
      bottom: PreferredSize(
        preferredSize: const Size.fromHeight(2),
        child: Container(height: 2, color: BB.ink),
      ),
    );
  }
}

class CourseScreen extends StatelessWidget {
  final Course course;
  const CourseScreen({super.key, required this.course});

  void _openLesson(BuildContext context, int i) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => LessonScreen(course: course, index: i),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final p = Progress.of(context);
    final done = p.doneCount(course);
    final pct = (p.fraction(course) * 100).round();
    final next = p.nextLesson(course);
    final allDone = done == course.lessons.length;

    return Scaffold(
      appBar: BBAppBar(course.title),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
        children: [
          BoxCard(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Mascot(course, size: 58),
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
                        course.description,
                        style: const TextStyle(fontSize: 13, height: 1.4),
                      ),
                      const SizedBox(height: 10),
                      Wrap(
                        spacing: 8,
                        children: [
                          MonoText('◆ ${course.level}', size: 11),
                          MonoText(
                            '◆ ${course.lessons.length} lessons',
                            size: 11,
                          ),
                          MonoText('◆ ${course.totalMinutes} min', size: 11),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Align(
            alignment: Alignment.centerRight,
            child: MonoText('$pct%', size: 12),
          ),
          const SizedBox(height: 4),
          BBProgressBar(p.fraction(course), height: 12),
          const SizedBox(height: 4),
          MonoText('$done/${course.lessons.length} Lessons', size: 12),
          const SizedBox(height: 14),
          YellowButton(
            label: allDone
                ? 'Review course'
                : (done == 0 ? 'Start course' : 'Continue course'),
            icon: allDone ? Icons.replay : Icons.play_arrow,
            onTap: () => _openLesson(context, allDone ? 0 : next),
          ),
          const SizedBox(height: 22),
          for (var i = 0; i < course.lessons.length; i++)
            Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: _LessonRow(
                index: i,
                lesson: course.lessons[i],
                done: p.isDone(course, i),
                isNext: !allDone && i == next,
                onTap: () => _openLesson(context, i),
              ),
            ),
        ],
      ),
    );
  }
}

class _LessonRow extends StatelessWidget {
  final int index;
  final Lesson lesson;
  final bool done;
  final bool isNext;
  final VoidCallback onTap;
  const _LessonRow({
    required this.index,
    required this.lesson,
    required this.done,
    required this.isNext,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return BoxCard(
      color: done ? BB.lavender : BB.card,
      shadow: isNext ? 3 : 0,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 16),
      child: Row(
        children: [
          if (done || isNext) ...[
            Icon(done ? Icons.play_arrow : Icons.play_arrow_outlined, size: 22),
            const SizedBox(width: 8),
          ],
          Expanded(
            child: Text(
              '${index + 1}. ${lesson.title}',
              style: TextStyle(
                fontSize: 15,
                fontWeight: isNext ? FontWeight.w800 : FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: 8),
          done ? const DoneSticker() : MonoText(lesson.duration, size: 12),
        ],
      ),
    );
  }
}
