import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:visitormanagement/constants/colors.dart';

import '../controller/visitor_form_controller.dart';
import '../widgets/custom_text_formfield_widget.dart';
import '../widgets/custom_text_widget.dart';
import 'package:path/path.dart' as p;

class VistorsFormScreen extends StatelessWidget {
  VistorsFormScreen({super.key});

  final VisitorFormController controller = Get.put(VisitorFormController());
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController purposeController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController placeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(
                'assets/logo/sample.png',
                height: 100,
              ),
              CustomTextFormField(
                hintText: 'Name',
                controller: nameController,
                onChanged: (value) {
                  controller.updateName(value);
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'Phone Number',
                controller: phoneNumberController,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  controller.updatePhoneNumber(value);
                },
              ),
              const SizedBox(height: 16),
              Container(
                height: 60,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 8,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: DropdownButtonFormField<String>(
                  padding:
                      const EdgeInsets.symmetric(vertical: 6, horizontal: 5),
                  items: ['Visitor', 'Employee', 'Guest']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child: Text(type),
                          ))
                      .toList(),
                  hint: const Text('Please select visitor type'),
                  onChanged: (value) {
                    if (value != null) {
                      controller.updateVisitorType(value);
                    }
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    filled: true,
                    fillColor: kWhiteColor,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'Purpose of visit',
                controller: purposeController,
                onChanged: (value) {
                  controller.updatePurposeOfVisit(value);
                },
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Obx(() {
                    return CutomOnTapButtonWidget(
                      title: controller.visitor.value.selectedDate ==
                              DateTime.now()
                          ? 'Select Date'
                          : controller.visitor.value.selectedDate
                              .toLocal()
                              .toString()
                              .split(' ')[0],
                      onTap: () async {
                        DateTime? date = await showDatePicker(
                          context: context,
                          initialDate: controller.visitor.value.selectedDate,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2101),
                        );
                        if (date != null) {
                          controller.updateSelectedDate(date);
                        }
                      },
                    );
                  }),
                  Obx(() {
                    return CutomOnTapButtonWidget(
                      title: controller.visitor.value.hasSelectedTime
                          ? controller.visitor.value.selectedTime
                              .format(context)
                          : 'Select Time',
                      onTap: () async {
                        TimeOfDay? time = await showTimePicker(
                          context: context,
                          initialTime: controller.visitor.value.selectedTime,
                        );
                        if (time != null) {
                          controller.updateSelectedTime(time);
                        }
                      },
                    );
                  }),
                ],
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'Email',
                controller: emailController,
                keyboardType: TextInputType.emailAddress,
                onChanged: (value) {
                  controller.updateEmail(value);
                },
              ),
              const SizedBox(height: 16),
              CustomTextFormField(
                hintText: 'Place',
                controller: placeController,
                onChanged: (value) {
                  controller.updatePlace(value);
                },
              ),
              const SizedBox(height: 16),
              Obx(() {
                return CutomOnTapButtonWidget(
                  width: double.infinity,
                  onTap: () async {
                    await controller.pickAndUploadImage();
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: CustomTextWidget(
                          title: controller.visitor.value.photoPath.isEmpty
                              ? 'Select Photo'
                              : p.basename(controller.visitor.value.photoPath),
                        ),
                      ),
                      const Icon(Icons.add_a_photo),
                    ],
                  ),
                );
              }),
              const SizedBox(height: 20),
              Obx(() {
                return SizedBox(
                  width: double.infinity,
                  height: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: kButtonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5),
                      ),
                    ),
                    onPressed: () async {
                      await controller.submitVisitorDetails();
                      Get.offNamed('/end');
                    },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: kBackgroundColor,
                          )
                        : const CustomTextWidget(
                            title: "Submit",
                            fontSize: 18,
                            color: kMainTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }
}

class CutomOnTapButtonWidget extends StatelessWidget {
  const CutomOnTapButtonWidget({
    super.key,
    this.onTap,
    this.title,
    this.width,
    this.child,
  });

  final Function()? onTap;
  final String? title;
  final double? width;
  final Widget? child;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width ?? (MediaQuery.of(context).size.width * 0.5) - 30,
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 8,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: child ?? CustomTextWidget(title: title ?? ''),
        ),
      ),
    );
  }
}
