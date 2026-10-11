/// Date Formatter.
abstract final class DateFormatter {
  static const _months = [
    'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
    'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec',
  ];
  static const _days = [
    'Monday', 'Tuesday', 'Wednesday', 'Thursday',
    'Friday', 'Saturday', 'Sunday',
  ];

  /// month name and date
  static String short(DateTime d) => '${_months[d.month - 1]} ${d.day}';

  /// month name  date, year
  static String full(DateTime d) => '${short(d)}, ${d.year}';

  /// month_name/date/year
  static String numeric(DateTime d) =>
      '${_two(d.month)}/${_two(d.day)}/${d.year}';

  /// Today • Date, month_name and date
  static String todayHeader(DateTime d) =>
      'Today • ${_days[d.weekday - 1]}, ${short(d)}';

  static String _two(int n) => n.toString().padLeft(2, '0');
}
