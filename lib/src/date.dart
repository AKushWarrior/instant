//    Instant, a time manipulation library for Dart.
//    Copyright (C) 2019 Aditya Kishore
//
//    See instant.dart for full license notice...

part of 'main.dart';

/// Formats DateTime into a # string with the date.
///
/// Ex. output is "12/04/2019".
///
/// Can be given 'MM' 'DD' and 'YYYY' OR 'YY' in any order for format (ex.
/// 'MMDDYY' 'YYYYDDMM' 'DDYYYYMM' 'MMDD' 'MMYYYY').
///
/// Can be given any divider (ex. '/' ':' '.').
String formatDate(
    {@required DateTime date,
    String format = "MMDDYYYY",
    String divider = "/"}) {
  var day = date.day;
  var month = date.month;
  var year = date.year;
  String returner = "";
  bool isLastYear = false;
  for (var l = 0; l < format.length; l += 2) {
    if (l != 0) {
      returner = returner + divider;
    }
    switch (format[l]) {
      case "M": {
        isLastYear = false;
        if (month >= 10) {
          returner = returner + '$month';
        } else {
          returner = returner + '0$month';
        }
      }
      break;
      case "D": {
        isLastYear = false;
        if (day >= 10) {
          returner = returner + '$day';
        } else {
          returner = returner + '0$day';
        }
      }
      break;
      case "Y": {
        if (!isLastYear) {
          if (int.parse(year.toString().substring(2)) >= 10) {
            returner = returner + year.toString().substring(2);
          } else {
            returner = returner + '0' + year.toString().substring(2);
          }
          isLastYear = true;
        } else {
          returner =
              returner.substring(0, returner.length - 3) + '$year';
          isLastYear = true;
        }
      }
      break;
      default: {
        throw ArgumentError("Invalid format passed!");
      }
    }
  }
  return returner;
}

/// Formats the local current date into a string.
///
/// Ex. output is "12/04/2019".
///
/// Can be given 'MM' 'DD' and 'YYYY' OR 'YY' in any order for format (ex.
/// 'MMDDYY' 'YYYYDDMM' 'DDYYYYMM' 'MMDD' 'MMYYYY').
///
/// Can be given any divider (ex. '/' ':' '.').
String formatCurDate({String format = "MMDDYYYY", String divider = "/"}) {
  var now = DateTime.now();
  return formatDate(date: now, format: format, divider: divider);
}

/// Returns the given DateTime's date in words (ex. 'January 19, 2019').
String dateInWords(DateTime date) {
  String dateInWords = "";
  Map<int, String> months = {
    1: "January",
    2: "February",
    3: "March",
    4: "April",
    5: "May",
    6: "June",
    7: "July",
    8: "August",
    9: "September",
    10: "October",
    11: "November",
    12: "December"
  };
  dateInWords = months[date.month] +
      " " +
      date.day.toString() +
      ", " +
      date.year.toString();
  return dateInWords;
}

/// Returns the local current date in words (ex. 'January 19, 2019').
String curDateInWords() {
  return dateInWords(DateTime.now());
}

/// Returns local current month as a # String formatted MM (ex. '04').
String curMonthAsString() {
  return formatCurDate(format: 'MM');
}

/// Returns local current day as a # String formatted DD (ex. '04').
String curDayAsString() {
  return formatCurDate(format: 'DD');
}

/// Returns local current year as a # String formatted YYYY (ex. '2019').
String curYearAsString() {
  return formatCurDate(format: 'YYYY');
}

/// Returns given DateTime's month as a # String formatted MM (ex. '04').
String monthAsString(DateTime date) {
  return formatDate(date: date, format: 'MM');
}

/// Returns given DateTime's day as a # String formatted DD (ex. '04').
String dayAsString(DateTime date) {
  return formatDate(date: date, format: 'DD');
}

/// Returns given DateTime's year as a # String formatted YYYY (ex. '2019').
String yearAsString(DateTime date) {
  return formatDate(date: date, format: 'YYYY');
}

/// Returns current month as an int (January == 1 ... December == 12).
int curMonthAsInt() {
  return DateTime.now().month;
}

/// Returns current day as an int (1 ... 31).
int curDayAsInt() {
  return DateTime.now().day;
}

/// Returns current year as an int (ex. 2019).
int curYearAsInt() {
  return DateTime.now().year;
}

/// Returns current day of the week as a text String.
String curWeekdayAsString() {
  Map<int, String> days = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  var now = DateTime.now();
  return days[now.weekday];
}

/// Returns day of the week of given DateTime as a text String.
String weekdayAsString({@required DateTime date}) {
  Map<int, String> days = {
    1: "Monday",
    2: "Tuesday",
    3: "Wednesday",
    4: "Thursday",
    5: "Friday",
    6: "Saturday",
    7: "Sunday"
  };
  return days[date.weekday];
}

///Returns approximate difference of given DateTimes in days as an int.
int diffInDays({@required DateTime x, @required DateTime y}) {
  x = x.toUtc();
  y = y.toUtc();
 Duration dur = x.difference(y);
 return dur.inDays;
}

///Returns approximate difference of given DateTimes in weeks as an int.
int diffInWeeks({@required DateTime x, @required DateTime y}) {
  Duration dur = x.difference(y);
  return (dur.inDays/7).round();
}

///Returns approximate difference of given DateTimes in months as an int.
int diffInMonths({@required DateTime x, @required DateTime y}) {
  Duration dur = x.difference(y);
  return (dur.inDays/30.44).round();
}

///Returns approximate difference of given DateTimes in years as an int.
int diffInYears({@required DateTime x, @required DateTime y}) {
  Duration dur = x.difference(y);
  return (dur.inDays/365.25).round();
}
