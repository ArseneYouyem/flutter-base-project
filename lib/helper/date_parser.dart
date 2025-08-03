import 'package:flutter/material.dart';

DateTime dateOnly(DateTime date) {
  return DateTime(date.year, date.month, date.day);
}

class DateParser {
  String? heureFormat;
  String? dateformat;
  String? dateformaString;
  String? dateformaFullString;
  String? time;
  String? dateTime;
  String? dateTimeString;
  String? dayMonthYear;
  String? dayMonth;
  String? dayMonthNum;
  String? dayMonthFull;
  String? monthYearFull;
  String? dayMonthYearFull;
  String? ecart;
  String? dailyEcart;
  String? chatEcart;
  String? dayweek;
  int? day;
  String? month;
  String? fullMonth;
  String? year;
  DateTime? date00h;
  DateTime? date23h;
  String? expirationCrediCard;

  ////

  String timeWithZero(int time) {
    return time <= 9 ? "0$time" : "$time";
  }

  DateParser(DateTime date) {
    DateTime curentDate = DateTime.now();
    date00h = DateTime(date.year, date.month, date.day, 0, 0, 0);
    date23h = DateTime(date.year, date.month, date.day, 23, 59, 59);

    String heure, minute, second;
    //heures
    heure = timeWithZero(date.hour);
    minute = timeWithZero(date.minute);
    second = timeWithZero(date.second);

//formatage de l'heure'
    heureFormat = '$heure:$minute';
    time = "$heureFormat:$second";
//formatage de la date'

//formatage des frangments de dates
    dayweek = '${date.weekday}';
    day = date.day;
    month = timeWithZero(date.month);
    year = '${date.year}';

    dateformat = '${date.day < 10 ? "0" : ""}$day/$month/$year';
    dateTime = "$dateformat à ${heure}h$minute";

    expirationCrediCard = "$month/${year?.substring(2)}";
    dayMonthNum = "$day/$month";

// jour de la semaine en lettre
    switch (date.weekday) {
      case 1:
        dayweek = "Lundi";
        break;
      case 2:
        dayweek = "Mardi";
        break;
      case 3:
        dayweek = "Mercredi";
        break;
      case 4:
        dayweek = "Jeudi";
        break;
      case 5:
        dayweek = "Vendredi";
        break;
      case 6:
        dayweek = "Samedi";
        break;
      case 7:
        dayweek = "Dimanche";
        break;
    }

// mois de l'année en lettre
    switch (date.month) {
      case 1:
        month = "Jan";
        fullMonth = "Janvier";
        break;
      case 2:
        month = "Fev";
        fullMonth = "Fevrier";
        break;
      case 3:
        month = "Mars";
        fullMonth = "Mars";
        break;
      case 4:
        month = "Avr";
        fullMonth = "Avril";
        break;
      case 5:
        month = "Mai";
        fullMonth = "Mai";
        break;
      case 6:
        month = "Juin";
        fullMonth = "Juin";
        break;
      case 7:
        month = "Juil";
        fullMonth = "Juillet";
        break;
      case 8:
        month = "Août";
        fullMonth = "Août";
        break;
      case 9:
        month = "Sep";
        fullMonth = "Septembre";
        break;
      case 10:
        month = "Oct";
        fullMonth = "Octobre";
        break;
      case 11:
        month = "Nov";
        fullMonth = "Novembre";
        break;
      case 12:
        month = "Dec";
        fullMonth = "Decembre";
        break;
    }

    // 14 février 2023, 16 heures
//formatage de la date avec jour et mois en lettre
    dateformaString = "$dayweek, $day $month $year";
    dateformaFullString = "$dayweek, $day $fullMonth $year";
    dayMonthYear = "$day $month $year";
    dayMonthYearFull = "$day $fullMonth $year";
    dayMonth = "$day $month";
    dayMonthFull = "$day $fullMonth";
    monthYearFull = "$fullMonth $year";
    dateTimeString = '$dateformaString à ${heureFormat!.replaceAll(':', 'h')}';

    //différence de jour entre la date courante et celle envoyée en paramettre
    Duration diff = curentDate.difference(date);

    bool sameYear = isSameYear(DateTime.now(), date);

    if (diff.inMinutes < 1 && diff.inDays < 1) {
      ecart = "à l'instant";
    } else if (diff.inMinutes >= 1 && diff.inMinutes < 60 && diff.inDays < 1) {
      ecart = "il y'a ${diff.inMinutes} Minutes";
    } else if (diff.inHours >= 1 && diff.inHours < 24 && diff.inDays < 1) {
      ecart = "il y'a ${diff.inHours} Heures";
    } else if (diff.inDays >= 1 && diff.inDays < 7) {
      ecart = "il y'a ${diff.inDays} Jours";
    } else if (diff.inDays >= 7 && diff.inDays < 31) {
      ecart = "il y'a ${(diff.inDays / 7).truncate()} Semaines";
    } else if (diff.inDays >= 31 && diff.inDays < 365) {
      ecart = "il y'a ${(diff.inDays / 30).truncate()} Mois";
    } else if (diff.inDays > 365) {
      ecart = "il y'a ${(diff.inDays / 365).truncate()} Ans";
    }
    if (diff.inDays == -1) {
      dailyEcart = "Demain";
    } else if (isSameDay(curentDate, date)) {
      dailyEcart = "Aujourd'hui";
      chatEcart = "$heure:$minute";
    } else if (!isSameDay(curentDate, date) &&
        diff.inDays < 1 &&
        diff.inDays > -1) {
      dailyEcart = "Hier";
      chatEcart = "Hier";
    } else {
      dailyEcart = "$day $fullMonth ${sameYear ? "" : "$year"}";
      chatEcart = "$day $month ${sameYear ? "" : "$year"}";
    }
    if (diff.inDays > 1 && diff.inDays < 6) {
      chatEcart = "$dayweek";
    }
    dailyEcart = "$dailyEcart - ${heure}H$minute";
  }

  static int getNumberOfDay(int numberOfMont) {
    DateTime dateActuelle = DateTime.now();
    DateTime dateFuture = DateTime(
        dateActuelle.year, dateActuelle.month + numberOfMont, dateActuelle.day);
    while (dateFuture.month !=
        ((dateActuelle.month + numberOfMont - 1) % 12) + 1) {
      dateFuture =
          DateTime(dateFuture.year, dateFuture.month, dateFuture.day - 1);
    }
    return dateFuture.difference(dateActuelle).inDays;
  }

  static DateTime firstDayOfMonth({DateTime? date}) {
    return DateTime(
        (date ?? DateTime.now()).year, (date ?? DateTime.now()).month, 1);
  }

  static DateTime lastDayOfMonth({DateTime? date}) {
    // Le premier jour du mois suivant
    DateTime firstDayOfNextMonth = DateTime(
        (date ?? DateTime.now()).year, (date ?? DateTime.now()).month + 1, 1);
    // On soustrait un jour pour obtenir le dernier jour du mois en cours
    DateTime lastDayOfMonth =
        firstDayOfNextMonth.subtract(Duration(seconds: 1));
    return lastDayOfMonth;
  }

  static String getTime(TimeOfDay time) {
    return "${time.hour > 9 ? "" : "0"}${time.hour}h${time.minute > 9 ? "" : "0"}${time.minute}";
  }

  static String getDay(int day, {bool full = false}) {
    return day == 1
        ? "Lun${full ? "di" : ""}"
        : day == 2
            ? "Mar${full ? "di" : ""}"
            : day == 3
                ? "Mer${full ? "credi" : ""}"
                : day == 4
                    ? "Jeu${full ? "di" : ""}"
                    : day == 5
                        ? "Ven${full ? "dredi" : ""}"
                        : day == 6
                            ? "Sam${full ? "edi" : ""}"
                            : "Dim${full ? "anche" : ""}";
  }

  static bool isSameDate(DateTime day1, DateTime day2) {
    return day1.day == day2.day &&
        day1.month == day2.month &&
        day1.year == day2.year &&
        day1.hour == day2.hour &&
        day1.minute == day2.minute &&
        day1.second == day2.second;
  }

  static bool isSameDay(DateTime day1, DateTime day2) {
    return day1.day == day2.day &&
        day1.month == day2.month &&
        day1.year == day2.year;
  }

  static bool isSameYear(DateTime day1, DateTime day2) {
    return day1.year == day2.year;
  }

  static bool firstIsAfter(String start, String end) {
    return DateTime.parse(start).isAfter(DateTime.parse(end)) ||
        DateTime.parse(start).difference(DateTime.parse(end)).inSeconds == 0;
  }

  static bool firstTimeIsGreather(TimeOfDay time1, TimeOfDay time2) {
    return (time1.hour * 60 + time1.minute) > (time2.hour * 60 + time2.minute);
  }
}
