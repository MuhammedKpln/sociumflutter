import 'package:easy_localization/easy_localization.dart';

DateFormat _dateFormat = DateFormat("dd MMMM yyyy", 'tr');

String formatDate(DateTime date) {
  return _dateFormat.format(date);
}
