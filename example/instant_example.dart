import 'dart:io';

import 'package:instant/instant.dart';

int c = 1;

void main(List<String> args) {
  var SanFran =
      curDateTimeByZone(zone: 'PDT'); //current DateTime in PDT timezone
  print(formatTime(time: SanFran)); //prints current time in PDT
  print(formatDate(date: SanFran)); //prints current date in PDT

  var watch = InstantStopwatch();
  watch.play();
  print(watch.stopwatchInSeconds);
  sleep(Duration(seconds: 2));
  print(watch.stopwatchInSeconds);
  watch.pause();
  sleep(Duration(seconds: 2));
  print(watch.stopwatchInSeconds);
  watch.play();
  sleep(Duration(seconds: 2));
  print(watch.stopwatchInSeconds);

  // This is largely a placeholder with the most barebones of usage. Check the
  // Gitbook and API docs for a much more thorough set of guides and examples.
}
