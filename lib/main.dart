import 'package:flutter/material.dart';

import 'progress.dart';
import 'screens/courses_screen.dart';
import 'screens/home_screen.dart';
import 'screens/progress_screen.dart';
import 'theme.dart';

void main() => runApp(const BigbullApp());

class BigbullApp extends StatefulWidget {
  const BigbullApp({super.key});
  @override
  State<BigbullApp> createState() => _BigbullAppState();
}

class _BigbullAppState extends State<BigbullApp> {
  final store = ProgressStore();

  @override
  Widget build(BuildContext context) {
    return Progress(
      store: store,
      child: MaterialApp(
        title: 'Bigbull',
        debugShowCheckedModeBanner: false,
        theme: BB.theme(),
        builder: (context, child) => PhoneFrame(child: child!),
        home: const Shell(),
      ),
    );
  }
}

/// On wide screens (web/desktop) shows the app inside a phone frame on a
/// green backdrop, like the design reference. On phones it is full-screen.
class PhoneFrame extends StatelessWidget {
  final Widget child;
  const PhoneFrame({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    if (size.width < 600) return child;
    const w = 410.0, h = 864.0; // device 390x844 + bezel
    return ColoredBox(
      color: BB.green,
      child: Stack(
        children: [
          const Positioned(left: 60, top: 50, child: _Flower(70)),
          const Positioned(right: 80, top: 90, child: _Flower(54)),
          const Positioned(right: 140, bottom: 70, child: _Flower(40)),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: FittedBox(
                child: Container(
                  width: w,
                  height: h,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: const Color(0xFF1A1A1A),
                    borderRadius: BorderRadius.circular(48),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black38,
                        blurRadius: 40,
                        offset: Offset(0, 20),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(38),
                    child: MediaQuery(
                      data: MediaQuery.of(context).copyWith(
                        size: const Size(w - 20, h - 20),
                        padding: const EdgeInsets.only(top: 28, bottom: 12),
                      ),
                      child: child,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Flower extends StatelessWidget {
  final double size;
  const _Flower(this.size);
  @override
  Widget build(BuildContext context) => Text(
    '✿',
    style: TextStyle(
      fontSize: size,
      color: const Color(0xFFFFF5D1),
      height: 1,
      decoration: TextDecoration.none,
    ),
    textDirection: TextDirection.ltr,
  );
}

class Shell extends StatefulWidget {
  const Shell({super.key});
  @override
  State<Shell> createState() => _ShellState();
}

class _ShellState extends State<Shell> {
  int tab = 0;
  static const _pages = [HomeScreen(), CoursesScreen(), ProgressScreen()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(index: tab, children: _pages),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: BB.card,
          border: Border(top: BorderSide(color: BB.ink, width: 2)),
        ),
        child: SafeArea(
          top: false,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                _NavItem(
                  Icons.home_rounded,
                  'Home',
                  tab == 0,
                  () => setState(() => tab = 0),
                ),
                _NavItem(
                  Icons.menu_book_rounded,
                  'Courses',
                  tab == 1,
                  () => setState(() => tab = 1),
                ),
                _NavItem(
                  Icons.insights_rounded,
                  'Progress',
                  tab == 2,
                  () => setState(() => tab = 2),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool active;
  final VoidCallback onTap;
  const _NavItem(this.icon, this.label, this.active, this.onTap);

  @override
  Widget build(BuildContext context) => Expanded(
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 4),
            decoration: BoxDecoration(
              color: active ? BB.yellow : Colors.transparent,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: active ? BB.ink : Colors.transparent,
                width: 1.5,
              ),
            ),
            child: Icon(icon, size: 22),
          ),
          const SizedBox(height: 2),
          Text(
            label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: active ? FontWeight.w800 : FontWeight.w500,
            ),
          ),
        ],
      ),
    ),
  );
}
