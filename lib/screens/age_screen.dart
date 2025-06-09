// ignore_for_file: deprecated_member_use

import 'package:fit_start/screens/result_screen.dart';
import 'package:fit_start/theme/theme_controller.dart';
import 'package:fit_start/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class AgeScreen extends StatefulWidget {
  const AgeScreen({super.key, required this.height, required this.weight});
  final String height;
  final String weight;

  @override
  State<AgeScreen> createState() => _AgeScreenState();
}

class _AgeScreenState extends State<AgeScreen> {
  final TextEditingController _ageController = TextEditingController();
  String selectedGender = '';

  void _selectGender(String gender) {
    setState(() {
      selectedGender = gender;
    });
  }

  @override
  void dispose() {
    _ageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onBackground;
    final fillColor =
        isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05);
    final borderColor =
        isDark ? Colors.white.withOpacity(0.3) : Colors.black.withOpacity(0.3);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Enter Your Age',
          style: TextStyle(
            color: theme.primaryColorDark,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          color: theme.primaryColorDark,
          onPressed: () {
            Get.back();
          },
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: textColor),
            onPressed: () => Get.find<ThemeController>().toggleTheme(),
          ),
        ],
      ),
      backgroundColor: theme.scaffoldBackgroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 200.h,
              height: 200.h,
              decoration: const BoxDecoration(shape: BoxShape.rectangle),
              child: Lottie.asset(
                'assets/animations/animation.json', // Replace with your Lottie animation path
                fit: BoxFit.fill,
              ),
            ),
            TextFormField(
              controller: _ageController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Enter your age',
                filled: true,
                fillColor: fillColor,
                labelStyle: TextStyle(color: textColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: borderColor),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: theme.primaryColor, width: 2.w),
                ),
              ),
              style: TextStyle(color: textColor),
            ),
            SizedBox(height: 30.h),
            Text(
              'Select Your Gender',
              style: theme.textTheme.headlineSmall?.copyWith(
                color: textColor,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _genderContainer(
                  'Male',
                  'assets/animations/male.json',
                  theme,
                  isDark,
                ),
                _genderContainer(
                  'Female',
                  'assets/animations/female.json',
                  theme,
                  isDark,
                ),
              ],
            ),
            SizedBox(height: 30.h),

            // Submit Button
            SubmitButton(
              onPressed: () {
                String age = _ageController.text;
                if (age.isEmpty || selectedGender.isEmpty) {
                  Get.showSnackbar(
                    GetSnackBar(
                      title: 'Error',
                      message: 'Please enter your age and select',
                      duration: Duration(seconds: 2),
                    ),
                  );
                } else {
                  Get.to(
                    () => ResultScreen(
                      height: widget.height,
                      weight: widget.weight,
                      age: _ageController.text,
                      gender: selectedGender,
                    ),
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _genderContainer(
    String gender,
    String imagePath,
    ThemeData theme,
    bool isDark,
  ) {
    bool isSelected = selectedGender == gender;
    final selectedBgColor = theme.primaryColorLight;
    final defaultBgColor =
        isDark ? Colors.white.withOpacity(0.1) : Colors.black.withOpacity(0.05);
    final borderColor =
        isSelected ? Colors.green : (isDark ? Colors.white : Colors.black);

    return GestureDetector(
      onTap: () => _selectGender(gender),
      child: Container(
        width: 110.w,
        height: 140.h,
        padding: EdgeInsets.all(15.w),
        decoration: BoxDecoration(
          color: isSelected ? selectedBgColor : defaultBgColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: borderColor, width: 2.w),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Center(
              child: Lottie.asset(
                imagePath,
                width: 70.w,
                height: 70.h,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              gender,
              style: TextStyle(
                fontSize: 16.h,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
