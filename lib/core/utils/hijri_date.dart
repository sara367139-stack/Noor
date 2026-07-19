import 'package:intl/intl.dart';

String getHijriDate() {
  return DateFormat.yMMMMEEEEd('ar').format(DateTime.now());
}