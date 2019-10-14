//    Instant, a date manipulation library for Dart.
//    Copyright (C) 2019 Aditya Kishore
//
//    See instant.dart for full license notice...

part of 'main.dart';

/// An alternative to the built in Stopwatch class.
/// This runs all its code in a separate Isolate, which saves memory.
/// It's also more sane than the traditional.
class InstantStopwatch {

  /// For internal use. DON'T USE!
  Isolate stopWatchIsolate;
  /// For internal use. DON'T USE!
  ReceivePort receivePort = ReceivePort();
  /// For internal use. DON'T USE!
  bool running = false;

  /// Initializes/resets the Stopwatch.
  /// This MUST be done before playing or pausing the Stopwatch.
  /// This leaves the stopwatch in a paused state.
  void init () async {
    stopWatchIsolate = await Isolate.spawn(run, receivePort.sendPort);
    stopWatchIsolate.pause(stopWatchIsolate.pauseCapability);
    running = false;
  }

  /// Starts the stopwatch. It will now count upward in increments of 1
  /// millisecond.
  void play () {
    stopWatchIsolate.resume(stopWatchIsolate.pauseCapability);
    running = true;
  }

  /// Pauses the stopwatch. It will now remain paused at the latest time.
  void pause () {
    stopWatchIsolate.pause(stopWatchIsolate.pauseCapability);
    running = false;
  }

  /// Returns true if the stopwatch is unpaused and false if paused.
  bool isRunning () {
    return running;
  }

  /// Destroys the stopwatch. This will save memory space. You will have to call
  /// init again if you want to use this object again.
  void destroy () {
    stopWatchIsolate.kill(priority: Isolate.immediate);
  }

  /// Returns the time that the stopwatch has recorded as elapsed as a Duration.
  Future<Duration> getStopwatchValue() async {
    var ms = await receivePort.lastWhere((dynamic element){return element.runtimeType == int;});
    return Duration(milliseconds: ms);
  }

  /// Returns the time that the stopwatch has recorded as elapsed in milliseconds.
  Future<int> getStopwatchInMilliseconds () async {
    var value = (await getStopwatchValue()).inMilliseconds;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in seconds.
  Future<int> getStopwatchInSeconds () async {
    var value = (await getStopwatchValue()).inSeconds;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in minutes.
  Future<int> getStopwatchInMinutes () async  {
    var value = (await getStopwatchValue()).inMinutes;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in hours.
  Future<int> getStopwatchInHours () async {
    var value = (await getStopwatchValue()).inHours;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in days.
  Future<int> getStopwatchInDays () async {
    var value = (await getStopwatchValue()).inDays;
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in weeks.
  Future<int> getStopwatchInWeeks () async {
    var value = ((await getStopwatchValue()).inDays/7).round();
    return value;
  }

  /// Returns the time that the stopwatch has recorded as elapsed in months.
  Future<int> getStopwatchInMonths () async {
    var value = ((await getStopwatchValue()).inDays/30.44).round();
    return value;
  }

  /// Purely for INTERNAL use. Don't use!
  void run(SendPort sendPort) {
    int counter = 0;
    Timer.periodic(Duration(milliseconds: 1), (Timer t) {
      counter++;
      sendPort.send(counter);
    });
  }
}