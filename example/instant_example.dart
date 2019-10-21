import 'dart:io';
import 'dart:async';

import 'package:instant/instant.dart';

int c = 1;

main() {
  DateTime SanFran = curDateTimeByZone(zone: "PDT"); //current DateTime in PDT timezone
  print(formatTime(time: SanFran)); //prints current time in PDT
  print(formatDate(date: SanFran)); //prints current date in PDT

  InstantStopwatch watch = InstantStopwatch();
  watch.play();
  print(watch.getStopwatchInSeconds());
  sleep(Duration(seconds: 2));
  print(watch.getStopwatchInSeconds());
  watch.pause();
  sleep(Duration(seconds: 2));
  print(watch.getStopwatchInSeconds());
  watch.play();
  sleep(Duration(seconds: 2));
  print(watch.getStopwatchInSeconds());

  // This is largely a placeholder with the most barebones of usage. Check the
  // Gitbook and API docs for a much more thorough set of guides and examples.
}
