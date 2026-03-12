import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:month_picker_dialog/month_picker_dialog.dart';
import 'package:omni_datetime_picker/omni_datetime_picker.dart';
import '../config/type.dart';

showDatePickerDialog(
    {required ParamsCallback<dynamic, DateTime> onDateSelect,
    bool dateOnly = true,
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
    bool lookPreviousDate = false}) {
  showOmniDateTimePicker(
    context: Get.context!,
    initialDate: initialDate ?? DateTime.now(),
    firstDate: lookPreviousDate ? DateTime.now() : firstDate ?? DateTime(1970),
    lastDate: lastDate ??
        (firstDate ?? DateTime(2024)).add(const Duration(days: 365 * 4)),
    theme: ThemeData.light().copyWith(
        colorScheme: const ColorScheme.light().copyWith(
            // surfaceTint: AppColor.blue210, primary: AppColor.primary,
            )),
    is24HourMode: true,
    type: dateOnly
        ? OmniDateTimePickerType.date
        : OmniDateTimePickerType.dateAndTime,
    minutesInterval: 1,
    secondsInterval: 1,
    isForce2Digits: true,
    borderRadius: const BorderRadius.all(Radius.circular(16)),
    barrierDismissible: true,
    selectableDayPredicate: (dateTime) {
      // Disable 25th Feb 2023
      // if (dateTime == DateTime(2024, 2, 17)) {
      //   return false;
      // } else {
      //   return true;
      // }
      return true;
    },
  ).then((value) {
    if (value != null) onDateSelect(value);
  });
}

showTimePickerDialog(
    {required ParamsCallback<dynamic, TimeOfDay> onDateSelect,
    TimeOfDay? initialTime}) {
  showTimePicker(
          context: Get.context!,
          initialTime: initialTime ?? TimeOfDay.now(),
          helpText: "Sélectionnez l'heure",
          hourLabelText: "Heure",
          minuteLabelText: "Minute")
      .then((value) {
    if (value != null) onDateSelect(value);
  });
}

showMonthPickerDialog(
    {String initialDate = "",
    bool loockFutureMonths = true,
    required ParamsCallback<dynamic, DateTime> onMonthSelect}) {
  showMonthPicker(
    context: Get.context!,
    initialDate:
        initialDate.isEmpty ? DateTime.now() : DateTime.parse(initialDate),
    lastDate: loockFutureMonths ? DateTime.now() : null,
    // locale: const Locale('fr', 'CA'),
  ).then((date) {
    if (date != null) {
      onMonthSelect(date);
    }
  });
}
