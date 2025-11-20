import 'package:intl/intl.dart';

final _percent = NumberFormat.decimalPercentPattern(decimalDigits: 1);
final _compact = NumberFormat.compact();

String formatPercent(double value) => _percent.format(value);
String formatCompact(num value) => _compact.format(value);
String formatDate(DateTime date) => DateFormat('MMM d').format(date);
String formatTime(DateTime date) => DateFormat('HH:mm').format(date);
