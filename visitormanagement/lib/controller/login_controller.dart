import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  var isLoading = false.obs;

  Future<void> login(String username, String password) async {
    try {
      isLoading.value = true;
      if (username.isEmpty) {
        Get.snackbar(
          'Error',
          'Username cannot be empty',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }
      if (password.isEmpty) {
        Get.snackbar(
          'Error',
          'Password cannot be empty',
          snackPosition: SnackPosition.TOP,
        );
        return;
      }

      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );

      User? user = userCredential.user;
      if (user != null) {
        Get.offNamed('/vistorForm');
      }
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Error', e.message ?? 'Login failed',
          snackPosition: SnackPosition.TOP);
    } finally {
      isLoading.value = false;
    }
  }
}
