import 'package:get/get.dart';
import 'package:intl/intl.dart';

mixin ChangeDataFormat {
  String created(DateTime createdOn) {
    if (day(createdOn) == yesterday) {
      return 'txt_yesterday'.tr;
    } else if (day(createdOn) == today) {
      DateTime now = DateTime.now();
      String todayValue = DateFormat('HH:mm').format(
        createdOn.add(
          Duration(hours: now.timeZoneOffset.inHours),
        ),
      );
      return '${'txt_today_at'.tr} $todayValue';
    } else {
      return DateFormat('dd.MM.yyyy').format(createdOn);
    }
  }

  DateTime day(DateTime date) {
    return DateTime(date.year, date.month, date.day);
  }

  DateTime get today {
    DateTime now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  DateTime get yesterday {
    DateTime now = DateTime.now();
    now = now.add(const Duration(days: -1));
    return DateTime(now.year, now.month, now.day);
  }
}
