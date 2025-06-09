// ignore_for_file: deprecated_member_use

import 'package:fit_start/controllers/auth_controller.dart';
import 'package:fit_start/screens/height_screen.dart';
import 'package:fit_start/theme/theme_controller.dart';
import 'package:fit_start/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResultScreen extends StatelessWidget {
  final String height; // in cm
  final String weight; // in kg
  final String age;
  final String gender;

  ResultScreen({
    super.key,
    required this.height,
    required this.weight,
    required this.age,
    required this.gender,
  });
  final AuthController _authController = Get.put(AuthController());

  double _calculateBMI() {
    final double h = double.tryParse(height) ?? 0;
    final double w = double.tryParse(weight) ?? 0;

    if (h == 0) return 0;

    final heightInMeters = h / 100;
    return w / (heightInMeters * heightInMeters);
  }

  String _bmiReview(double bmi) {
    // Basic positive review logic with some BMI ranges
    if (bmi < 18.5) {
      return "You are a bit underweight, keep a balanced diet!";
    } else if (bmi < 25) {
      return "You are fit and healthy! Keep it up!";
    } else if (bmi < 30) {
      return "You are slightly overweight, consider a healthy lifestyle!";
    } else {
      return "Stay motivated! Healthy habits help a lot!";
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final bmi = _calculateBMI();
    final review = _bmiReview(bmi);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Your BMI Result',
          style: TextStyle(
            color: theme.primaryColorDark,
            fontWeight: FontWeight.bold,
            fontSize: 20.sp,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.primaryColorDark),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: theme.colorScheme.onSurface),
            onPressed: () => Get.find<ThemeController>().toggleTheme(),
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 40.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Age: $age years',
              style: TextStyle(
                fontSize: 18.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Gender: $gender',
              style: TextStyle(
                fontSize: 18.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Height: $height cm',
              style: TextStyle(
                fontSize: 18.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Weight: $weight kg',
              style: TextStyle(
                fontSize: 18.sp,
                color: theme.colorScheme.onSurface,
              ),
            ),

            SizedBox(height: 40.h),

            Text(
              'Your BMI is',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.onSurface,
              ),
            ),
            SizedBox(height: 12.h),

            Text(
              bmi > 0 ? bmi.toStringAsFixed(2) : '--',
              style: TextStyle(
                fontSize: 48.sp,
                fontWeight: FontWeight.bold,
                color: theme.primaryColor,
              ),
            ),

            SizedBox(height: 40.h),

            Container(
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color:
                    isDark
                        ? Colors.green.withOpacity(0.2)
                        : Colors.green.withOpacity(0.15),
                borderRadius: BorderRadius.circular(16.r),
              ),
              child: Text(
                review,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
            ),

            SizedBox(height: 40.h),
            RoundButton(
              onPressed: () {
                Get.offAll(
                  () => HeightScreen(),
                  transition: Transition.leftToRight,
                  duration: Duration(milliseconds: 300),
                );
              },
              text: 'Back to Home',
            ),
            SizedBox(height: 20.h),
            RoundButton(
              onPressed: () {
                _authController.logout();
              },
              text: 'Log out',
            ),
          ],
        ),
      ),
    );
  }
}
