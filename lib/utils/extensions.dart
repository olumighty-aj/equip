import 'package:intl/intl.dart';

extension AddressParsing on String {
  String extractCountry() {
    // Regular expression for matching country
    RegExp countryRegExp = RegExp(r'(?<=,\s)([A-Za-z]+)$');

    // Match country
    Iterable<RegExpMatch> countryMatches = countryRegExp.allMatches(this);
    return countryMatches.isNotEmpty ? countryMatches.first.group(1)! : '';
  }

  // String extractState() {
  //   // Regular expression for matching state
  //   RegExp stateRegExp = RegExp(r'(?<=,\s)([A-Za-z]+),\s*[A-Za-z]+(?=,|$)');
  //
  //   // Match state
  //   Iterable<RegExpMatch> stateMatches = stateRegExp.allMatches(this);
  //   return stateMatches.isNotEmpty ? stateMatches.first.group(1)! : '';
  // }
  String extractState() {
    // Regular expression for matching state
    RegExp stateRegExp = RegExp(r'(?<=,\s)([A-Za-z\s]+),\s*[A-Za-z\s]+(?=,|$)');

    // Match state
    // Match state
    Iterable<RegExpMatch> stateMatches = stateRegExp.allMatches(this);
    if (stateMatches.isNotEmpty) {
      String state = stateMatches.first.group(1)!;

      // Check for specific state values and map them
      if (state == 'Federal Capital Territory') {
        return 'Abuja';
      } else {
        return state;
      }
    } else {
      return '';
    }
  }
}

extension DateHelpers on DateTime {
  bool isToday() {
    final now = DateTime.now();
    return now.day == day && now.month == month && now.year == year;
  }

  bool isYesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return yesterday.day == day &&
        yesterday.month == month &&
        yesterday.year == year;
  }

  String toDate() {
    String date = DateFormat.yMMMd().format(this);
    return date;
  }

  String toDashDate() {
    String date = DateFormat("yyyy-MM-dd").format(this);
    return date;
  }

  String toDay() {
    String day = DateFormat.EEEE().format(this);
    return day;
  }

  String toTime() {
    String time = DateFormat.jm().format(this);
    return time;
  }

  DateTime toDateTimeDate() {
    return DateTime(this.year, this.month, this.day);
  }
}

extension StringToDateTimeExtension on String {
  DateTime parseDateString() {
    DateFormat dateFormat = DateFormat('MMM d, y');
    return dateFormat.parse(this);
  }
}
