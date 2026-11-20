import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'data/courses.dart';
import 'progress.dart';
import 'theme.dart';

/// Card with thick black outline and a hard offset shadow (neo-brutalist look).
class BoxCard extends StatelessWidget {
  final Widget child;
  final Color color;
  final EdgeInsets padding;
  final VoidCallback? onTap;
  final double shadow;
  const BoxCard({
    super.key,
    required this.child,
    this.color = BB.card,
    this.padding = const EdgeInsets.all(14),
    this.onTap,
    this.shadow = 3,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: BB.ink, width: 2),
        boxShadow: shadow == 0
            ? null
            : [BoxShadow(color: BB.ink, offset: Offset(shadow, shadow))],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        clipBehavior: Clip.antiAlias,
        child: InkWell(
          onTap: onTap,
          child: Padding(padding: padding, child: child),
        ),
      ),
    );
  }
}

/// Round "sticker" mascot for a course.
class Mascot extends StatelessWidget {
  final Course course;
  final double size;
  const Mascot(this.course, {super.key, this.size = 52});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: course.color,
        shape: BoxShape.circle,
        border: Border.all(color: BB.ink, width: 2),
        boxShadow: const [BoxShadow(color: BB.ink, offset: Offset(2, 2))],
      ),
      child: Text(course.emoji, style: TextStyle(fontSize: size * 0.5)),
    );
  }
}

/// Thin striped progress bar like the reference design.
class BBProgressBar extends StatelessWidget {
  final double value;
  final double height;
  const BBProgressBar(this.value, {super.key, this.height = 10});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: BB.ink, width: 1.5),
      ),
      child: LayoutBuilder(
        builder: (context, c) => Align(
          alignment: Alignment.centerLeft,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            width: c.maxWidth * value.clamp(0, 1),
            color: BB.yellow,
          ),
        ),
      ),
    );
  }
}

class MonoText extends StatelessWidget {
  final String text;
  final double size;
  final Color color;
  final FontWeight weight;
  const MonoText(
    this.text, {
    super.key,
    this.size = 12,
    this.color = BB.ink,
    this.weight = FontWeight.w400,
  });

  @override
  Widget build(BuildContext context) => Text(
    text,
    style: TextStyle(
      fontFamily: BB.mono,
      fontFamilyFallback: const ['Courier New', 'Courier'],
      fontSize: size,
      color: color,
      fontWeight: weight,
    ),
  );
}

class Pill extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback? onTap;
  const Pill(this.label, {super.key, this.selected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
        decoration: BoxDecoration(
          color: selected ? BB.yellow : BB.card,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: BB.ink, width: 1.5),
          boxShadow: selected
              ? const [BoxShadow(color: BB.ink, offset: Offset(2, 2))]
              : null,
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            MonoText(
              label,
              size: 12,
              weight: selected ? FontWeight.w700 : FontWeight.w400,
            ),
            if (selected) ...[
              const SizedBox(width: 4),
              const Icon(Icons.close, size: 12),
            ],
          ],
        ),
      ),
    );
  }
}

/// Tilted yellow "DONE!" sticker.
class DoneSticker extends StatelessWidget {
  const DoneSticker({super.key});
  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: -0.15,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
        decoration: BoxDecoration(
          color: BB.yellow,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: BB.ink, width: 1.5),
          boxShadow: const [BoxShadow(color: BB.ink, offset: Offset(1.5, 1.5))],
        ),
        child: const Text(
          'DONE!',
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 11,
            letterSpacing: .5,
          ),
        ),
      ),
    );
  }
}

class YellowButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;
  const YellowButton({
    super.key,
    required this.label,
    required this.onTap,
    this.icon = Icons.play_arrow,
  });

  @override
  Widget build(BuildContext context) {
    return BoxCard(
      color: BB.yellow,
      onTap: onTap,
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, size: 18),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
          ),
        ],
      ),
    );
  }
}

class SectionTitle extends StatelessWidget {
  final String text;
  const SectionTitle(this.text, {super.key});
  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.only(top: 22, bottom: 10),
    child: Text(
      text,
      style: const TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w800,
        letterSpacing: -0.5,
      ),
    ),
  );
}

/// Compact course row used in lists.
class CourseTile extends StatelessWidget {
  final Course course;
  final VoidCallback onTap;
  const CourseTile(this.course, {super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final p = Progress.of(context);
    final done = p.doneCount(course);
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: BoxCard(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Mascot(course, size: 46),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          course.title,
                          style: const TextStyle(
                            fontWeight: FontWeight.w800,
                            fontSize: 15,
                          ),
                        ),
                      ),
                      MonoText('${course.totalMinutes} min', size: 11),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    course.description,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 12.5,
                      color: BB.muted,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      _Tag(course.level),
                      const SizedBox(width: 6),
                      _Tag(course.category),
                      const Spacer(),
                      MonoText('$done/${course.lessons.length}', size: 11),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  final String text;
  const _Tag(this.text);
  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
    decoration: BoxDecoration(
      border: Border.all(color: BB.ink, width: 1),
      borderRadius: BorderRadius.circular(4),
    ),
    child: MonoText(text, size: 10),
  );
}

/// Candlestick illustration used as the "video" artwork.
class CandlePainter extends CustomPainter {
  final int seed;
  final double t; // 0..1 reveal
  CandlePainter(this.seed, this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final rnd = math.Random(seed);
    const n = 22;
    final w = size.width / n;
    var price = 0.5;
    final grid = Paint()
      ..color = Colors.white10
      ..strokeWidth = 1;
    for (var i = 1; i < 5; i++) {
      final y = size.height * i / 5;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), grid);
    }
    final visible = (n * (0.35 + 0.65 * t)).ceil();
    for (var i = 0; i < n; i++) {
      final open = price;
      final close = (open + (rnd.nextDouble() - 0.45) * 0.12).clamp(0.12, 0.88);
      final hi = math.max(open, close) + rnd.nextDouble() * 0.05;
      final lo = math.min(open, close) - rnd.nextDouble() * 0.05;
      price = close;
      if (i >= visible) continue;
      final up = close >= open;
      final paint = Paint()
        ..color = up ? const Color(0xFF4CE07B) : const Color(0xFFFF6B6B);
      final x = i * w + w / 2;
      double y(double v) => size.height * (1 - v);
      canvas.drawLine(
        Offset(x, y(hi)),
        Offset(x, y(lo)),
        paint..strokeWidth = 1.5,
      );
      canvas.drawRect(
        Rect.fromLTRB(
          x - w * 0.3,
          y(math.max(open, close)),
          x + w * 0.3,
          y(math.min(open, close)) + 1,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(CandlePainter old) => old.t != t || old.seed != seed;
}
