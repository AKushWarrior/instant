//    Instant, a time manipulation library for Dart.
//    Copyright (C) 2019 Aditya Kishore
//
//    See instant.dart for full license notice...

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

  /// Starts the stopwatch. It will now count upward in increments of 1
  /// millisecond.
  void play () {
    _running = true;
    _orig = DateTime.now();
  }

  /// Pauses the stopwatch. It will now remain paused at the latest time.
  void pause () {
    _atPause = _atPause + Duration(milliseconds: run(_orig));
    _running = false;
  }

  /// Resets stopwatch back to zero.
  void reset () {
    pause();
    _running = false;
    _atPause = Duration(microseconds: 0);
  }

  /// Returns true if the stopwatch is unpaused and false if paused.
  bool isRunning () {
    return _running;
  }

  /// Returns the time that the stopwatch has recorded as elapsed as a Duration.
  Duration getStopwatchValue() {
    if (!_running) {
      _orig = DateTime.now();
    }
    return Duration(milliseconds: run(_orig)) + _atPause;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in milliseconds.
  int getStopwatchInMilliseconds () {
    var value = (getStopwatchValue()).inMilliseconds;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in seconds.
  int getStopwatchInSeconds () {
    var value = (getStopwatchValue()).inSeconds;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in minutes.
  int getStopwatchInMinutes () {
    var value = (getStopwatchValue()).inMinutes;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in hours.
  int getStopwatchInHours () {
    var value = (getStopwatchValue()).inHours;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in days.
  int getStopwatchInDays () {
    var value = (getStopwatchValue()).inDays;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in weeks.
  int getStopwatchInWeeks (){
    var value = ((getStopwatchValue()).inDays/7).round();
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in months.
  int getStopwatchInMonths () {
    var value = ((getStopwatchValue()).inDays/30.44).round();
    return value;
  }

  /// INTERNAL | DON'T USE
  int run (DateTime orig) {
    return diffInMillisecs(x: DateTime.now(), y: orig);
  }
}