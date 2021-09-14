import 'package:intl/intl.dart';

extension DateTimeExtension on DateTime {
  String formatddMMyyyy() {
    String value = DateFormat('dd/MM/yyyy').format(this);
    return value;
  }
}
