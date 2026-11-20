import 'package:flutter/widgets.dart';

import 'data/courses.dart';

/// Tracks completed lessons and the last course the learner opened.
class ProgressStore extends ChangeNotifier {
  final Set<String> _done = {};
  String? lastCourseId;

  String _key(Course c, int i) => '${c.id}:$i';

  bool isDone(Course c, int i) => _done.contains(_key(c, i));

  int doneCount(Course c) {
    var n = 0;
    for (var i = 0; i < c.lessons.length; i++) {
      if (isDone(c, i)) n++;
    }
    return n;
  }

  double fraction(Course c) => doneCount(c) / c.lessons.length;

  /// First lesson not yet completed (or last lesson if all done).
  int nextLesson(Course c) {
    for (var i = 0; i < c.lessons.length; i++) {
      if (!isDone(c, i)) return i;
    }
    return c.lessons.length - 1;
  }

  int get totalDone => _done.length;
  int get coursesCompleted =>
      courses.where((c) => doneCount(c) == c.lessons.length).length;

  void open(Course c) {
    lastCourseId = c.id;
    notifyListeners();
  }

  void complete(Course c, int i) {
    _done.add(_key(c, i));
    lastCourseId = c.id;
    notifyListeners();
  }

  void toggle(Course c, int i) {
    final k = _key(c, i);
    _done.contains(k) ? _done.remove(k) : _done.add(k);
    notifyListeners();
  }

  Course? get lastCourse => lastCourseId == null
      ? null
      : courses.firstWhere((c) => c.id == lastCourseId);
}

class Progress extends InheritedNotifier<ProgressStore> {
  const Progress({
    super.key,
    required ProgressStore store,
    required super.child,
  }) : super(notifier: store);

  static ProgressStore of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<Progress>()!.notifier!;
}
