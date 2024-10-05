import 'package:intl/intl.dart';

class DateManager {

  bool twoDateIsSameDay(DateTime date1, DateTime date2){
      return date1.year == date2.year && date1.month == date2.month && date1.day == date2.day;
  }
  bool dateIsToday(DateTime date1){
    DateTime today = DateTime.now();
    return twoDateIsSameDay(today, date1);
  }

  int getCurrentTimeStamp() {
    return DateTime.now().millisecondsSinceEpoch;
  }

  int getNext2Year() {
    return DateTime.now().millisecondsSinceEpoch + 63113904000;
  }

  String getTodayString(String format) {
    var now = DateTime.now();
    var formatter = DateFormat(format);
    return formatter.format(now);
  }

  getFormattedDateString(String text) {
    String formattedDate = "";
    try {
      DateTime reformattedDate = DateFormat("dd/MM/yyyy").parse(text);
      formattedDate = DateFormat('yyyy-MM-dd').format(reformattedDate);
    } catch (error) {
      formattedDate = "";
    }
    return formattedDate;
  }

  String formatStringFromDate(String data) {
    String stringDate = '';
    try {
      var formattedDate = DateFormat("dd/MM/yyyy").format(DateTime.parse(data));
      stringDate = formattedDate.toString();
    } catch (error) {
      stringDate = "";
    }
    return stringDate;
  }

  getDatesFromRange(String text) {
    final splitted = text.split(' - ');
    splitted[0] = splitted[0].substring(0,10);
    splitted[1] = splitted[1].substring(0,10);
    return splitted;
  }

  formatData(DateTime data, String format) {
    String formattedDate = "";
    try {
      formattedDate = DateFormat(format).format(data);
    } catch (error) {
      formattedDate = "";
    }
    return formattedDate;
  }

  formatDataFromString(String data, String format) {
    String formattedDate = "";
    try {
      formattedDate = DateFormat(format).format(DateTime.parse(data));
    } catch (error) {
      formattedDate = "";
    }
    return formattedDate;
  }

  double? transformTimeInDecimal(String hours, String minutes) {
    int? hoursParsed = int.tryParse(hours);
    int? minutesParsed = int.tryParse(minutes);

    if (hoursParsed == null ||
        minutesParsed == null ||
        hoursParsed > 24 ||
        minutesParsed > 59) {
      return null;
    } else {
      double minutesInDecimal =
      double.parse((minutesParsed / 60).toStringAsFixed(2));
      double result = hoursParsed + minutesInDecimal;
      return result;
    }
  }

  String transformTimeHours(double time) {
    String timeString = time.toString();
    final splitted = timeString.split('.');
    return splitted[0];
  }

  String transformTimeMinutes(double time) {
    String timeString = time.toString();
    final splitted = timeString.split('.');
    final minutes = int.parse(splitted[1]);
    String computedMinutes = '';
    if (minutes < 25) {
      computedMinutes = '0';
    } else if (minutes == 25) {
      computedMinutes = '15';
    } else if (minutes == 50) {
      computedMinutes = '30';
    } else if (minutes == 75) {
      computedMinutes = '45';
    }
    return computedMinutes;
  }


  /* funzione presa da plas */
  String transformDecimalInTimeString(double? value,
      {daysDivision = false, onlyValues = false}) {
    if (value == null) {
      return "";
    }
    String stringTransform = value.toStringAsFixed(2);
    List<String> arrayValues = stringTransform.split(".");
    int integer = int.parse(arrayValues[0]);
    int decimal = int.parse(arrayValues[1]);
    int days = 0;
    int hours = 0;
    int minutes = 0;
    dynamic result;

    if (decimal > 0) {
      num absMinutes = num.parse(((decimal / 100) * 60).toStringAsFixed(2));
      minutes = absMinutes.floor();
    }
    if (!daysDivision) {
      hours = integer;
      if (onlyValues) {
        result = {hours, minutes};
      } else {
        result = "${hours}H, ${minutes}m";
      }
    } else {
      if (integer > 23) {
        num absDays = num.parse((integer / 24).toStringAsFixed(2));
        days = absDays.floor();
        String stringDays = "$absDays";
        List<String> arrayHour = stringDays.split(".");
        int decimalArrayhour = int.parse(arrayHour[1]);
        if (decimalArrayhour > 0) {
          num absHours = num.parse(
              ((decimalArrayhour / 100) * 24).toStringAsFixed(2));

          hours = absHours.floor();
        }
      } else {
        hours = integer;
      }
      if (onlyValues) {
        result = {days, hours, minutes};
      } else {
        result = "${days}G, ${hours}H, ${minutes}m";
      }
    }
    return result;
  }

  String parseOrNull(String? dateEnd) {
    return ((dateEnd != null) ? DateFormat.yMMMd().format(DateTime.parse(dateEnd)).toString()  : "Indeterminato");
  }

  String getFirstDayMonth() {
    DateTime now = DateTime.now();
    String firstDayOfMonth = DateFormat('yyyy-MM-dd').format(DateTime(now.year, now.month, 1));
    return firstDayOfMonth;
  }

  String getEndDateFromRange(dateStart, dateEnd, newStart){
    DateTime start = DateTime.parse(dateStart);
    DateTime end = DateTime.parse(dateEnd);
    final difference = end.difference(start).inDays;
    DateTime result = DateTime.now();
    if(newStart != null){
      DateTime nStart = DateTime.parse(newStart);
      result = nStart.add(Duration(days:difference)); 
    }else{
      result = DateTime.now().add(Duration(days:difference));
    }
    return DateFormat('yyyy-MM-dd').format(result);
  }

  

}
