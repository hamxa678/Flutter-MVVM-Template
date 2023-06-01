import 'package:intl/intl.dart';

class DateTimeService {
  static formateDate(DateTime? dateTime) {
    final dateFormat = DateFormat.yMd();
    if (dateTime != null) return dateFormat.format(dateTime);
  }
}
