import 'package:flutter/material.dart';

import '../data/courses.dart';
import '../progress.dart';
import '../theme.dart';
import '../widgets.dart';
import 'course_screen.dart';

class LessonScreen extends StatefulWidget {
  final Course course;
  final int index;
  const LessonScreen({super.key, required this.course, required this.index});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _player;
  int? _picked;

  Lesson get lesson => widget.course.lessons[widget.index];

  Duration get _length {
    final p = lesson.duration.split(':');
    return Duration(minutes: int.parse(p[0]), seconds: int.parse(p[1]));
  }

  @override
  void initState() {
    super.initState();
    _player = AnimationController(vsync: this, duration: _length);
  }

  @override
  void dispose() {
    _player.dispose();
    super.dispose();
  }

  String _fmt(Duration d) =>
      '${d.inMinutes}:${(d.inSeconds % 60).toString().padLeft(2, '0')}';

  void _togglePlay() {
    setState(() {
      if (_player.isAnimating) {
        _player.stop();
      } else {
        if (_player.isCompleted) _player.reset();
        _player.forward();
      }
    });
  }

  void _completeAndNext() {
    final p = Progress.of(context);
    p.complete(widget.course, widget.index);
    final isLast = widget.index == widget.course.lessons.length - 1;
    if (isLast) {
      showDialog(
        context: context,
        builder: (_) => Dialog(
          backgroundColor: Colors.transparent,
          child: BoxCard(
            padding: const EdgeInsets.all(22),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Mascot(widget.course, size: 72),
                const SizedBox(height: 14),
                const Text(
                  'Course complete! 🎉',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
                ),
                const SizedBox(height: 6),
                Text(
                  'You finished ${widget.course.title}.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 18),
                YellowButton(
                  label: 'Back to course',
                  icon: Icons.check,
                  onTap: () {
                    Navigator.of(context)
                      ..pop()
                      ..pop();
                  },
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (_) =>
              LessonScreen(course: widget.course, index: widget.index + 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final p = Progress.of(context);
    final done = p.isDone(widget.course, widget.index);
    final quiz = lesson.quiz;
    final isLast = widget.index == widget.course.lessons.length - 1;

    return Scaffold(
      appBar: BBAppBar(lesson.title),
      body: ListView(
        padding: EdgeInsets.zero,
        children: [
          _VideoHero(
            course: widget.course,
            index: widget.index,
            player: _player,
            length: _length,
            fmt: _fmt,
            onToggle: _togglePlay,
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(18, 18, 18, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                MonoText(
                  'LESSON ${widget.index + 1} OF ${widget.course.lessons.length} · ${lesson.duration}',
                  size: 11,
                  color: BB.muted,
                ),
                const SizedBox(height: 6),
                const Text(
                  'Lesson notes',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    letterSpacing: -0.8,
                  ),
                ),
                const SizedBox(height: 4),
                for (final (h, body) in lesson.sections) ...[
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Container(width: 10, height: 10, color: BB.yellow),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          h,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Text(
                    body,
                    style: const TextStyle(fontSize: 15, height: 1.55),
                  ),
                ],
                const SizedBox(height: 22),
                BoxCard(
                  color: const Color(0xFFDFF5E3),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🔑  Key takeaways',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      for (final k in lesson.keyPoints)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                '✓  ',
                                style: TextStyle(fontWeight: FontWeight.w900),
                              ),
                              Expanded(
                                child: Text(
                                  k,
                                  style: const TextStyle(height: 1.35),
                                ),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 18),
                BoxCard(
                  color: BB.lavender,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        '🧩  Quick quiz',
                        style: TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        quiz.question,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          height: 1.35,
                        ),
                      ),
                      const SizedBox(height: 10),
                      for (var i = 0; i < quiz.options.length; i++)
                        _QuizOption(
                          text: quiz.options[i],
                          state: _picked == null
                              ? _Opt.idle
                              : i == quiz.answer
                              ? _Opt.correct
                              : i == _picked
                              ? _Opt.wrong
                              : _Opt.idle,
                          onTap: _picked == null
                              ? () => setState(() => _picked = i)
                              : null,
                        ),
                      if (_picked != null) ...[
                        const SizedBox(height: 4),
                        Text(
                          (_picked == quiz.answer
                                  ? '✅ Correct! '
                                  : '❌ Not quite. ') +
                              quiz.explain,
                          style: const TextStyle(fontSize: 13.5, height: 1.4),
                        ),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 22),
                YellowButton(
                  label: isLast
                      ? (done ? 'Finish course' : 'Complete & finish')
                      : (done ? 'Next lesson' : 'Mark complete & next'),
                  icon: isLast ? Icons.flag : Icons.arrow_forward,
                  onTap: _completeAndNext,
                ),
                const SizedBox(height: 14),
                const Text(
                  'For education only. Not investment advice. Markets carry risk.',
                  style: TextStyle(fontSize: 11, color: BB.muted),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _VideoHero extends StatelessWidget {
  final Course course;
  final int index;
  final AnimationController player;
  final Duration length;
  final String Function(Duration) fmt;
  final VoidCallback onToggle;
  const _VideoHero({
    required this.course,
    required this.index,
    required this.player,
    required this.length,
    required this.fmt,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: player,
      builder: (context, _) {
        final playing = player.isAnimating;
        return Container(
          decoration: const BoxDecoration(
            color: Color(0xFF16201A),
            border: Border(bottom: BorderSide(color: BB.ink, width: 2)),
          ),
          child: Column(
            children: [
              AspectRatio(
                aspectRatio: 16 / 10,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(14, 30, 14, 14),
                        child: CustomPaint(
                          painter: CandlePainter(
                            course.id.hashCode + index,
                            playing || player.value > 0 ? player.value : 1,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 12,
                      top: 10,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: course.color,
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(color: BB.ink, width: 1.5),
                        ),
                        child: Text(
                          '${course.emoji}  ${course.title}',
                          style: const TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ),
                    Center(
                      child: GestureDetector(
                        onTap: onToggle,
                        child: AnimatedOpacity(
                          opacity: playing ? 0.35 : 1,
                          duration: const Duration(milliseconds: 200),
                          child: Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: BB.yellow,
                              shape: BoxShape.circle,
                              border: Border.all(color: BB.ink, width: 2),
                              boxShadow: const [
                                BoxShadow(color: BB.ink, offset: Offset(3, 3)),
                              ],
                            ),
                            child: Icon(
                              playing ? Icons.pause : Icons.play_arrow,
                              size: 34,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                child: Row(
                  children: [
                    MonoText(
                      fmt(length * player.value),
                      size: 11,
                      color: Colors.white70,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: LinearProgressIndicator(
                          value: player.value,
                          minHeight: 4,
                          backgroundColor: Colors.white24,
                          color: BB.yellow,
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    MonoText(fmt(length), size: 11, color: Colors.white70),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

enum _Opt { idle, correct, wrong }

class _QuizOption extends StatelessWidget {
  final String text;
  final _Opt state;
  final VoidCallback? onTap;
  const _QuizOption({required this.text, required this.state, this.onTap});

  @override
  Widget build(BuildContext context) {
    final color = switch (state) {
      _Opt.correct => const Color(0xFF8EE3A5),
      _Opt.wrong => const Color(0xFFFFA7A7),
      _Opt.idle => BB.card,
    };
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: BoxCard(
        color: color,
        shadow: 0,
        onTap: onTap,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 11),
        child: Row(
          children: [
            Expanded(child: Text(text)),
            if (state == _Opt.correct) const Icon(Icons.check_circle, size: 18),
            if (state == _Opt.wrong) const Icon(Icons.cancel, size: 18),
          ],
        ),
      ),
    );
  }
}
