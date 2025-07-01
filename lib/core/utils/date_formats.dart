import 'package:intl/intl.dart';

import 'extension.dart';

class DateFormats {
  static const String dateFormatServer = "yyyy-MM-DDTHH:mm:ss.SSSSSSZ";
  static const String dateFormatToday = "yyyy-MM-DD HH:mm:ss.SSSSSS";
  static const String dateFormatYYYYMMSSHHMMSS = "yyyy-MM-dd HH:mm:ss";
  static const String dateFormatYYYYMMSSTHHMMSS = "yyyy-MM-ddTHH:mm:ss";
  static const String dateFormatDDMMMMEEEE = "dd MMMM, EEEE";

  static const String dateFormatDDMMYYY = "dd/MM/yyyy";
  static const String dateFormatDDMMYYYYDes = "dd-MM-yyyy";
  static const String dateFormatDDMYYYY = "dd/M/yyyy";
  static const String dateFormatYYYYMDD = "yyyy-MM-dd";
  static const String dateFormatMMMMYYYY = "MMMM yyyy";
  static const String dateFormatMMYYYY = "MM/yyyy";
  static const String dateFormatDDMMM = "dd MMM";
  static const String dateFormatMMMY = "MMM y";
  static const String dateFormatMMMMY = "MMMM y";
  static const String dateFormatDD = "dd";
  static const String dateFormatMMMM = "MMMM";
  static const String dateFormatMMM = "MMM";
  static const String dateFormatMM= "MM";
  static const String dateFormatHHMMA = "hh:mma";
  static const String dateFormatHHMMSS = "HH:mm:ss";
  static const String dateFormatHHMM = "HH:mm";
  static const String dateFormatHH = "HH";
  static const String dateFormatM = "M";
  static const String dateFormatEE = "EE";
  static const String dateFormatEEE = "EEE";
  static const dateFormatWithDay = "dd MMM, yyyy";
  static const dateFormatWithDayName = "dd MMM, EEEE";
}

// String dateToAgoFormat(String dateTime, String inputFormat) {
//   DateTime tempDate = DateTime.now();
//   if (dateTime.isNotEmpty) {
//     tempDate = DateFormat(inputFormat).parse(dateTime);
//   }
//   return timeago.format(tempDate);
// }

String formatDate(DateTime inputDate, String outputFormat) {
  return DateFormat(outputFormat).format(inputDate);
}

String getCurrentDate() {
  return DateFormat(DateFormats.dateFormatYYYYMDD).format(DateTime.now());
}

String convertToUTC(String? dateTime) {
  return changeDateFormat(DateTime.parse("$dateTime").toLocal().toString(),
      DateFormats.dateFormatToday, DateFormats.dateFormatHHMMA);
}


String getDaysName(String dateTime, inputFormat) {
  DateTime inputDate = DateTime.now();
  if (dateTime.isNotNullOrEmpty()) {
    inputDate = DateFormat(inputFormat).parse(dateTime);
  }
  return DateFormat('EEE').format(inputDate);
}



String changeDateFormat(
    String? dateTime, String inputFormat, String outputFormat) {
  DateTime inputDate = DateTime.now();
  if (dateTime.isNotNullOrEmpty()) {
    inputDate = DateFormat(inputFormat).parse(dateTime!);
  }
  return DateFormat(outputFormat).format(inputDate);
}

bool showTimer(val) {
  return DateTime.now()
      .compareTo(DateFormat(DateFormats.dateFormatDDMMYYY).parse(val)) ==
      -1;
}

bool checkCurrentDate(val) {
  return DateTime.now()
      .compareTo(DateFormat(DateFormats.dateFormatDDMMYYY).parse(val)) >
      0;
}

String hhMM(val) {
  if (val != null) {
    var inputFormat = DateFormat(DateFormats.dateFormatHHMMSS);
    var invoiceDates = inputFormat.parse(val);
    var outputFormat = DateFormat(DateFormats.dateFormatHHMMA);
    return outputFormat.format(invoiceDates);
  }
  return "";
}

/// Returns the suffix for the given number, such as 'st' for 1 or 'th' for 11.
String getSuffix(int number) {
  if (number % 100 >= 11 && number % 100 <= 13) {
    return 'th';
  } else {
    switch (number % 10) {
      case 1:
        return 'st';
      case 2:
        return 'nd';
      case 3:
        return 'rd';
      default:
        return 'th';
    }
  }
}
