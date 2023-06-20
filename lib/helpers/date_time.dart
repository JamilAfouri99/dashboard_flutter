import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String get ymd => DateFormat('MMM dd, yyyy').format(this);

  String get toFormattedDateString {
    DateFormat outputFormat = DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'");
    return outputFormat.format(this);
  }
}
