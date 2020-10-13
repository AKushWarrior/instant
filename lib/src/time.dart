//    Instant, a time manipulation library for Dart.
//    Copyright (C) 2019 Aditya Kishore
//
//    See instant.dart for full license notice...
// ignore_for_file: omit_local_variable_types, prefer_single_quotes
// ignore_for_file: non_constant_identifier_names, directives_ordering
// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types
// ignore_for_file: annotate_overrides
part of 'main.dart';

/// Formats DateTime into a # string with the time.
///
/// Ex. output is "02:08:13 P.M." for is24hr == false.
/// Ex. output is "14:08:13" for is24hr == true.
///
/// Can be given 'HH' (hour) 'MM' (minute) 'SS' (second) 'III' (millisecond) and 'OOO' (microsecond)
/// in any order for format (ex. 'HHMMSS' 'MMSSIII' 'MM' 'SS' 'HHMM').
///
/// Can be given any divider (ex. ':' '.' '/').
///
/// Can be given either true or false for 24hr time.
String formatTime(
    {@required DateTime time,
    String format = "HHMMSS",
    String divider = ":",
    bool is24hr = true}) {
  var minute = time.minute;
  var second = time.month;
  var hour = time.hour;
  var milli = time.millisecond;
  var micro = time.microsecond;

  String returner = "";
  for (var l = 0; l < format.length; l += 2) {
    if (l != 0) {
      returner = returner + divider;
    }
    switch (format[l]) {
      case "H":
        {
          if (is24hr == true) {
            if (hour >= 10) {
              returner = returner + '$hour';
            } else {
              returner = returner + '0$hour';
            }
          } else {
            if (hour < 10) {
              returner = returner + '0$hour';
            } else if (hour > 10 && hour <= 12) {
              returner = returner + '$hour';
            } else {
              if (hour - 12 < 10) {
                returner = returner + '0${hour - 12}';
              } else {
                returner = returner + '${hour - 12}';
              }
            }
          }
        }
        break;
      case "M":
        {
          if (minute >= 10) {
            returner = returner + '$minute';
          } else {
            returner = returner + '0$minute';
          }
        }
        break;
      case "S":
        {
          if (second >= 10) {
            returner = returner + '$second';
          } else {
            returner = returner + '0$second';
          }
        }
        break;
      case "I":
        {
          l++;
          if (milli >= 100) {
            returner = returner + '$milli';
          } else if (milli < 10) {
            returner = returner + '00$milli';
          } else {
            returner = returner + '0$milli';
          }
        }
        break;
      case "O":
        {
          l++;
          if (micro >= 100) {
            returner = returner + '$micro';
          } else if (micro < 10) {
            returner = returner + '00$micro';
          } else {
            returner = returner + '0$micro';
          }
        }
        break;
      default:
        {
          throw ArgumentError("Invalid format passed!");
        }
        break;
    }
  }
  if (!is24hr) {
    if (hour > 12) {
      returner = returner + " P.M.";
    } else {
      returner = returner + " A.M.";
    }
  }
  return returner;
}

/// Formats DateTime into a # string with the time.
///
/// Ex. output is "02:08:13 P.M." for is24hr == false.
/// Ex. output is "14:08:13" for is24hr == true.
///
/// Can be given 'HH' (hour) 'MM' (minute) 'SS' (second) and 'II' (millisecond)
/// in any order for format (ex. 'HHMMSS' 'MMSSII' 'MM' 'SS' 'HHMM').
///
/// Can be given any divider (ex. ':' '.' '/').
///
/// Can be given either true or false for 24hr time.
String formatCurTime(
    {String format = "HHMMSS", String divider = ":", bool is24hr = false}) {
  var now = DateTime.now();
  return formatTime(
      time: now, format: format, divider: divider, is24hr: is24hr);
}

/// Returns given DateTime's microsecond as a # String formatted III (ex. '004').
String microsecAsString(DateTime time) {
  return formatTime(time: time, format: 'OOO');
}

/// Returns given DateTime's millisecond as a # String formatted III (ex. '004').
String millisecAsString(DateTime time) {
  return formatTime(time: time, format: 'III');
}

/// Returns given DateTime's second as a # String formatted SS (ex. '04').
String secAsString(DateTime time) {
  return formatTime(time: time, format: 'SS');
}

/// Returns given DateTime's minute as a # String formatted MM (ex. '04').
String minAsString(DateTime time) {
  return formatTime(time: time, format: 'MM');
}

/// Returns given DateTime's hour as a # String formatted HH (ex. '14').
String hrAsString(DateTime time) {
  return formatTime(time: time, format: 'HH');
}

/// Returns local current DateTime's millisecond as a # String formatted III
/// (ex. '004').
String get curMillisecAsString {
  return formatTime(time: DateTime.now(), format: 'III');
}

/// Returns local current DateTime's second as a # String formatted SS (ex. '04').
String get curSecAsString {
  return formatTime(time: DateTime.now(), format: 'SS');
}

/// Returns local current DateTime's minute as a # String formatted MM (ex. '04').
String get curMinAsString {
  return formatTime(time: DateTime.now(), format: 'MM');
}

/// Returns local current DateTime's hour as a # String formatted HH (ex. '14').
String get curHrAsString {
  return formatTime(time: DateTime.now(), format: 'HH');
}

/// Returns current millisecond as an int (0...999).
int get curMillisecAsInt {
  return DateTime.now().millisecond;
}

/// Returns current second as an int (0...59).
int get curSecAsInt {
  return DateTime.now().second;
}

/// Returns local current minute as an int (0...59).
int get curMinAsInt {
  return DateTime.now().minute;
}

/// Returns local current hour as an int (1...24).
int get curHrAsInt {
  return DateTime.now().hour;
}
