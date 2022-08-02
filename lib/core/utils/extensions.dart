import 'package:intl/intl.dart';

extension ReadableDate on DateTime {
  String get readableDate {
    return DateFormat('MMMM dd, yyyy').format(this);
  }
}
