import 'package:fit_start/screens/height_screen.dart';
import 'package:fit_start/screens/login/login_page.dart';
import 'package:fit_start/services/storage_services.dart';
import 'package:fit_start/services/supabase_services.dart';
import 'package:fit_start/utils/storage_keys.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthController extends GetxController {
  var registerloading = false.obs;
  var loginloading = false.obs;
  Future<void> register(String name, String email, String password) async {
    try {
      registerloading.value = true;
      final AuthResponse data = await SupabaseServices.client.auth.signUp(
        password: password,
        email: email,
        data: {'name': name},
      );

      if (data.user != null) {
        StorageServices.session.write(
          StorageKeys.userSession,
          data.session!.toJson(),
        );
      }
      registerloading.value = false;
      Get.showSnackbar(
        GetSnackBar(
          title: "Registration Successful",
          message: "Please complete your profile.",
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      Get.to(() => HeightScreen(), transition: Transition.rightToLeft);
    } on AuthException catch (e) {
      debugPrint(e.message);
      registerloading.value = false;
      Get.snackbar(
        "Registration Failed",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }

  Future<void> login(String email, String password) async {
    try {
      loginloading.value = true;
      final AuthResponse data = await SupabaseServices.client.auth
          .signInWithPassword(password: password, email: email);
      loginloading.value = false;
      if (data.user != null) {
        StorageServices.session.write(
          StorageKeys.userSession,
          data.session!.toJson(),
        );
        debugPrint(
          "User logged in: ${StorageServices.session.read(StorageKeys.userSession)}",
        );
      }
      Get.showSnackbar(
        GetSnackBar(
          title: "Login Successful",
          message: "Welcome back!",
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
      Get.offAll(() => HeightScreen(), transition: Transition.rightToLeft);
    } on AuthException catch (e) {
      debugPrint(e.message);
      Get.snackbar(
        "Login Failed",
        e.message,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
      loginloading.value = false;
    }
  }

  Future<void> logout() async {
    try {
      await SupabaseServices.client.auth.signOut();

      await StorageServices.session.remove(StorageKeys.userSession);

      Get.offAll(() => LoginPage());

      Get.showSnackbar(
        GetSnackBar(
          title: "Logged Out",
          message: "You have been successfully logged out.",
          duration: Duration(seconds: 2),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint("Logout Error: $e");
      Get.snackbar(
        "Logout Failed",
        "An error occurred during logout. Please try again.",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white,
      );
    }
  }
}
