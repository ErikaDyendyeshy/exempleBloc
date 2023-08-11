import 'package:intl/intl.dart';

class Utils {
  static String formatRuntime(int totalMinutes) {
    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    final formattedHours = hours > 0 ? '${hours} год' : '';
    final formattedMinutes = minutes > 0 ? ' ${minutes} хв' : '';

    return '$formattedHours$formattedMinutes';
  }


  static String formatFullDate(String date) {
    final inputFormat = DateFormat('yyyy-MM-dd');
    final inputDate = inputFormat.parse(date);

    final outputFormat = DateFormat('dd MMMM yyyy', 'uk_UA');
    final formattedDate = outputFormat.format(inputDate);

    return formattedDate;
  }
}
