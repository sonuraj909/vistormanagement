import 'package:flutter/material.dart';

class Visitor {
  String name;
  String phoneNumber;
  String visitorType;
  String purposeOfVisit;
  DateTime selectedDate;
  TimeOfDay selectedTime;
  String email;
  String place;
  String photoPath;
  bool hasSelectedTime;
  bool hasSelectedDate;

  Visitor({
    required this.name,
    required this.phoneNumber,
    required this.visitorType,
    required this.purposeOfVisit,
    required this.selectedDate,
    required this.selectedTime,
    required this.email,
    required this.place,
    required this.photoPath,
    required this.hasSelectedTime,
    required this.hasSelectedDate,
  });
  // Map<String, dynamic> toJson() {
  //   return {
  //     'name': name,
  //     'phoneNumber': phoneNumber,
  //     'visitorType': visitorType,
  //     'purposeOfVisit': purposeOfVisit,
  //     'selectedDate': selectedDate.toIso8601String(),
  //     'selectedTime': selectedTime.format(Get.context!),
  //     'email': email,
  //     'place': place,
  //     'photoPath': photoPath,
  //     'hasSelectedTime': hasSelectedTime,
  //     'hasSelectedDate': hasSelectedDate,
  //   };
  // }
}
