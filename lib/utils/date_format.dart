import 'package:intl/intl.dart';

bool sameDay(DateTime first, DateTime second) {
  return first.day == second.day && first.month == second.month && first.year == second.year;
}

bool isYesterday(DateTime date) {
  final now = DateTime.now().subtract(const Duration(days: 1));
  return sameDay(date, now);
}

String formatDate(DateTime date) {
  final now = DateTime.now();
  if (sameDay(date, now)) {
    return "today at ${DateFormat("h:mm a").format(date)}";
  } else if (isYesterday(date)) {
    return "yestered at ${DateFormat("h:mm a").format(date)}";
  }

  return "on ${DateFormat("M/d/y").format(date)}";
}
