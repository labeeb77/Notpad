  import 'package:intl/intl.dart';

class Utils{
  static String formatDate(DateTime dateTime) {
    final formatter = DateFormat('MMMM d, y');
    return formatter.format(dateTime);
  }
}