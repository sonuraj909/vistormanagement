import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitormanagement/constants/colors.dart';
import 'package:visitormanagement/constants/core.dart';

import '../widgets/custom_text_widget.dart';

class EndScreen extends StatelessWidget {
  const EndScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo/sample.png',
              height: 100,
            ),
            const CustomTextWidget(
              title: 'Submitted',
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            const CustomTextWidget(
              title: 'Successfully',
              fontSize: 32,
              fontWeight: FontWeight.w600,
            ),
            kHeight30,
            SizedBox(
              width: double.infinity,
              height: 60,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: kButtonColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                onPressed: () {
                  // Login functionality
                  Get.offNamed('/splash');
                },
                child: const CustomTextWidget(
                  title: "Back To Home",
                  fontSize: 18,
                  color: kMainTextColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
