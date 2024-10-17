import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../handler/permission_handler.dart';
import '../models/vistor_form_model.dart';

class VisitorFormController extends GetxController {
  var visitor = Visitor(
    name: '',
    phoneNumber: '',
    visitorType: '',
    purposeOfVisit: '',
    selectedDate: DateTime.now(),
    selectedTime: TimeOfDay.now(),
    email: '',
    place: '',
    photoPath: '',
    hasSelectedTime: false,
    hasSelectedDate: false,
  ).obs;
  var isLoading = false.obs;

  // Update methods
  void updateName(String value) => visitor.update((val) => val?.name = value);
  void updatePhoneNumber(String value) =>
      visitor.update((val) => val?.phoneNumber = value);
  void updateVisitorType(String value) =>
      visitor.update((val) => val?.visitorType = value);
  void updatePurposeOfVisit(String value) =>
      visitor.update((val) => val?.purposeOfVisit = value);
  void updateEmail(String value) => visitor.update((val) => val?.email = value);
  void updatePlace(String value) => visitor.update((val) => val?.place = value);
  void updateSelectedDate(DateTime date) => visitor.update((val) {
        val?.selectedDate = date;
        val?.hasSelectedDate = true;
      });
  void updateSelectedTime(TimeOfDay time) => visitor.update((val) {
        val?.selectedTime = time;
        val?.hasSelectedTime = true;
      });

  // Image picking method
  Future<void> pickAndUploadImage() async {
    await requestStoragePermission();
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      visitor.update((val) {
        val?.photoPath = pickedFile.path;
      });
    }
  }

  // Method to upload photo to Firebase Storage
  Future<String> uploadPhoto(String userId, String path) async {
    try {
      final storageRef = FirebaseStorage.instance.ref();
      final photoRef = storageRef.child(
          'visitor_photos/$userId/${DateTime.now().millisecondsSinceEpoch}.jpg');

      await photoRef.putFile(File(path));

      String downloadUrl = await photoRef.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      Get.snackbar(
        'Error',
        'Error uploading photo: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );

      return '';
    }
  }

  Future<void> submitVisitorDetails() async {
    try {
      isLoading.value = true;
      String? photoUrl;

      final FirebaseAuth auth = FirebaseAuth.instance;
      final userId = FirebaseAuth.instance.currentUser?.uid;

      // Upload photo if it exists
      if (userId != null && visitor.value.photoPath.isNotEmpty) {
        photoUrl = await uploadPhoto(userId, visitor.value.photoPath);
      } else {}

      // Prepare the visitor data
      final visitorData = {
        'name': visitor.value.name,
        'phoneNumber': visitor.value.phoneNumber,
        'visitorType': visitor.value.visitorType,
        'purposeOfVisit': visitor.value.purposeOfVisit,
        'selectedDate': visitor.value.selectedDate.toIso8601String(),
        'selectedTime': visitor.value.selectedTime.format(Get.context!),
        'email': visitor.value.email,
        'place': visitor.value.place,
        'photoUrl': photoUrl ?? '',
      };

      // Submit to Firestore
      await FirebaseFirestore.instance.collection('visitors').add(visitorData);
      resetVisitorData();
      await auth.signOut();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Failed to submit visitor details: ${e.toString()}',
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Reset visitor data
  void resetVisitorData() {
    visitor.value = Visitor(
      name: '',
      phoneNumber: '',
      visitorType: '',
      purposeOfVisit: '',
      selectedDate: DateTime.now(),
      selectedTime: TimeOfDay.now(),
      email: '',
      place: '',
      photoPath: '',
      hasSelectedTime: false,
      hasSelectedDate: false,
    );
  }
}
