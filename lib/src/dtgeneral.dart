part of 'main.dart';

// ignore_for_file: omit_local_variable_types, prefer_single_quotes
// ignore_for_file: non_constant_identifier_names, directives_ordering
// ignore_for_file: prefer_typing_uninitialized_variables, camel_case_types
// ignore_for_file: annotate_overrides

/// Adds given amount (amount) of given units (units) to given DateTime (orig).
///
/// Returns the modified DateTime.
///
/// Accepted units are:
///
/// - 'ms' (milliseconds)
///
/// - 's' (seconds)
///
/// - 'min' (minutes)
///
/// - 'h' (hours)
///
/// - 'd' (days)
///
/// - 'w' (weeks)
///
/// - 'mon' (months)
///
/// - 'y' (years)
DateTime add(
    {@required DateTime orig, @required int amount, @required String units}) {
  switch (units) {
    case "ms":
      orig = orig.add(Duration(milliseconds: amount));
      break;
    case "s":
      orig = orig.add(Duration(seconds: amount));
      break;
    case "min":
      orig = orig.add(Duration(minutes: amount));
      break;
    case "h":
      orig = orig.add(Duration(hours: amount));
      break;
    case "d":
      orig = orig.add(Duration(days: amount));
      break;
    case "w":
      orig = orig.add(Duration(days: amount * 7));
      break;
    case "mon":
      orig = _addMonths(orig, amount);
      break;
    case "y":
      orig = _addMonths(orig, amount * 12);
      break;
    default:
      throw ArgumentError(
          "This unit is unsupported. See docs for supported units...");
  }
  return orig;
}

/// Subtracts given amount (amount) of given units (units) from given DateTime (orig).
///
/// Returns the modified DateTime.
///
/// Accepted units are:
///
/// - 'ms' (milliseconds)
///
/// - 's' (seconds)
///
/// - 'min' (minutes)
///
/// - 'h' (hours)
///
/// - 'd' (days)
///
/// - 'w' (weeks)
///
/// - 'mon' (months)
///
/// - 'y' (years)
DateTime subtract(
    {@required DateTime orig, @required int amount, @required String units}) {
  switch (units) {
    case "ms":
      orig = orig.subtract(Duration(milliseconds: amount));
      break;
    case "s":
      orig = orig.subtract(Duration(seconds: amount));
      break;
    case "min":
      orig = orig.subtract(Duration(minutes: amount));
      break;
    case "h":
      orig = orig.subtract(Duration(hours: amount));
      break;
    case "d":
      orig = orig.subtract(Duration(days: amount));
      break;
    case "w":
      orig = orig.subtract(Duration(days: amount * 7));
      break;
    case "mon":
      orig = _addMonths(orig, -amount);
      break;
    case "y":
      orig = _addMonths(orig, -amount * 12);
      break;
    default:
      throw ArgumentError(
          "This unit is unsupported. See docs for supported units...");
  }
  return orig;
}

/// Returns exact amount of given unit (units) between the two DateTimes.
/// This accounts for leapyears and other time-based anomalies.
///
/// Accepted units are:
///
/// - 'ms' (milliseconds)
///
/// - 's' (seconds)
///
/// - 'min' (minutes)
///
/// - 'h' (hours)
///
/// - 'd' (days)
///
/// - 'w' (weeks)
///
/// - 'mon' (months)
///
/// - 'y' (years)
num exactDiff(
    {@required DateTime x,
    @required DateTime y,
    String units = "ms",
    bool asFloat = false}) {
  num diff;
  switch (units) {
    case "ms":
      diff = x.difference(y).inMilliseconds;
      break;
    case "s":
      diff = x.difference(y).inSeconds;
      break;
    case "min":
      diff = x.difference(y).inMinutes;
      break;
    case "h":
      diff = x.difference(y).inHours;
      break;
    case "d":
      diff = x.difference(y).inDays;
      break;
    case "w":
      diff = x.difference(y).inDays / 7;
      break;
    case "mon":
      diff = _monthDiff(x, y);
      break;
    case "y":
      diff = _monthDiff(x, y) / 12;
      break;
    default:
      throw ArgumentError("Unsupported format...");
  }
  if (!asFloat) return _absFloor(diff);
  return diff;
}

num _monthDiff(DateTime a, DateTime b) {
  int wholeMonthDiff = ((b.year - a.year) * 12) + (b.month - a.month);
  DateTime anchor = _addMonths(a, wholeMonthDiff);
  DateTime anchor2;
  var adjust;

  if (b.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch < 0) {
    anchor2 = _addMonths(a, wholeMonthDiff - 1);
    adjust = (b.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch) /
        (anchor.millisecondsSinceEpoch - anchor2.millisecondsSinceEpoch);
  } else {
    anchor2 = _addMonths(a, wholeMonthDiff + 1);
    adjust = (b.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch) /
        (anchor2.millisecondsSinceEpoch - anchor.millisecondsSinceEpoch);
  }
  return -(wholeMonthDiff + adjust) ?? 0;
}

int _absFloor(num number) {
  if (number < 0) {
    return number.ceil() ?? 0;
  } else {
    return number.floor();
  }
}

const _daysInMonthArray = [0, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31];

bool _isLeapYear(int year) =>
    (year % 4 == 0) && ((year % 100 != 0) || (year % 400 == 0));

int _daysInMonth(int year, int month) {
  var result = _daysInMonthArray[month];
  if (month == 2 && _isLeapYear(year)) result++;
  return result;
}

DateTime _addMonths(DateTime dt, int value) {
  var r = value % 12;
  var q = (value - r) ~/ 12;
  var newYear = dt.year + q;
  var newMonth = dt.month + r;
  if (newMonth > 12) {
    newYear++;
    newMonth -= 12;
  }
  var newDay = min(dt.day, _daysInMonth(newYear, newMonth));
  if (dt.isUtc) {
    return DateTime.utc(newYear, newMonth, newDay, dt.hour, dt.minute,
        dt.second, dt.millisecond, dt.microsecond);
  } else {
    return DateTime(newYear, newMonth, newDay, dt.hour, dt.minute, dt.second,
        dt.millisecond, dt.microsecond);
  }
}
