import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get ymd => DateFormat('MMM dd, yyyy').format(this);
}
