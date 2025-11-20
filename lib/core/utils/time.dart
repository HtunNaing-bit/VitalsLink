DateTime startOfDay(DateTime date) => DateTime(date.year, date.month, date.day);

DateTime addDays(DateTime date, int days) => date.add(Duration(days: days));

Iterable<DateTime> recentDays(int count) sync* {
  final now = DateTime.now();
  for (var i = count - 1; i >= 0; i--) {
    yield startOfDay(now.subtract(Duration(days: i)));
  }
}
