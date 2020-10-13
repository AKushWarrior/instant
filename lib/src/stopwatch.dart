//    Instant, a time manipulation library for Dart.
//    Copyright (C) 2019 Aditya Kishore
//
//    See instant.dart for full license notice...

// ignore_for_file: omit_local_variable_types, prefer_single_quotes
// ignore_for_file: non_constant_identifier_names, directives_ordering
// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types
// ignore_for_file: annotate_overrides

part of 'main.dart';

/// An alternative to the built in Stopwatch class.
///
/// This doesn't run in the background and instead uses time comparisons,
/// which saves a LOT of memory.
///
/// It's also more somewhat more sane than the traditional.
class InstantStopwatch {
  DateTime _orig;

  bool _running = false;

  Duration _atPause = Duration(microseconds: 0);

  /// Constructs the stopwatch. If you want the stopwatch to begin at a certain
  /// time, pass a millisecond amount to start at.
  InstantStopwatch({int fromMS = 0}) {
    _orig = subtract(orig: DateTime.now().toUtc(), amount: fromMS, units: 'ms');
    pause();
  }

  /// Starts the stopwatch. It will now count upward in increments of 1
  /// millisecond.
  void play() {
    if (!_running) {
      _running = true;
      _orig = DateTime.now().toUtc();
    }
  }

  /// Pauses the stopwatch. It will now remain paused at the latest time.
  void pause() {
    if (_running) {
      _atPause = _atPause + Duration(milliseconds: _run(_orig));
      _running = false;
    }
  }

  /// Resets stopwatch back to zero.
  void reset() {
    if (_running) {
      pause();
      _running = false;
      _atPause = Duration(microseconds: 0);
    } else {
      _atPause = Duration(microseconds: 0);
    }
  }

  /// Returns true if the stopwatch is playing and false if paused.
  bool isRunning() {
    return _running;
  }

  /// Returns the time that the stopwatch has recorded as elapsed as a Duration.
  Duration get stopwatchValue {
    if (!_running) {
      _orig = DateTime.now().toUtc();
    }
    return Duration(milliseconds: _run(_orig)) + _atPause;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in milliseconds.
  int get stopwatchInMilliseconds {
    var value = (stopwatchValue).inMilliseconds;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in seconds.
  int get stopwatchInSeconds {
    var value = (stopwatchValue).inSeconds;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in minutes.
  int get stopwatchInMinutes {
    var value = (stopwatchValue).inMinutes;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in hours.
  int get stopwatchInHours {
    var value = (stopwatchValue).inHours;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in days.
  int get stopwatchInDays {
    var value = (stopwatchValue).inDays;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in weeks.
  int get stopwatchInWeeks {
    var value = ((stopwatchValue).inDays / 7).round();
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in months.
  int get stopwatchInMonths {
    var value = ((stopwatchValue).inDays / 30.44).round();
    return value;
  }

  int _run(DateTime orig) {
    return exactDiff(x: DateTime.now().toUtc(), y: orig);
  }
}
