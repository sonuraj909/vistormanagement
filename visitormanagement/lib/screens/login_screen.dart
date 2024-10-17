import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visitormanagement/constants/colors.dart';
import 'package:visitormanagement/constants/core.dart';
import 'package:visitormanagement/widgets/custom_text_formfield_widget.dart';
import '../controller/login_controller.dart';
import '../widgets/custom_text_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  final LoginController controller = Get.put(LoginController());
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              kHeight50,
              Image.asset(
                'assets/logo/sample.png',
                height: 150,
              ),
              const CustomTextWidget(
                title: 'Welcome Back',
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),

              const CustomTextWidget(
                title: 'Please fill the details to login',
                fontSize: 18,
              ),
              kHeight30,
              CustomTextFormField(
                hintText: "Username",
                controller: usernameController,
              ),

              kHeight15,

              CustomTextFormField(
                hintText: "Password",
                isPassword: true,
                controller: passwordController,
              ),

              kHeight20,
              // Login Button
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
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.login(
                              usernameController.text.trim(),
                              passwordController.text.trim(),
                            );
                          },
                    child: controller.isLoading.value
                        ? const CircularProgressIndicator(
                            color: kBackgroundColor,
                          )
                        : const CustomTextWidget(
                            title: "Login",
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
