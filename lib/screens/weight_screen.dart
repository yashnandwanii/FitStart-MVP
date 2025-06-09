// ignore_for_file: deprecated_member_use

import 'package:fit_start/screens/age_screen.dart';
import 'package:fit_start/theme/theme_controller.dart';
import 'package:fit_start/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class WeightScreen extends StatefulWidget {
  const WeightScreen({super.key, required this.height});
  final String height;

  @override
  State<WeightScreen> createState() => _WeightScreenState();
}

class _WeightScreenState extends State<WeightScreen> {
  final TextEditingController _kgController = TextEditingController();
  double _weightKg = 70;
  double _sliderValue = 70.0;

  void _updateWeightFromInput() {
    double kg = double.tryParse(_kgController.text) ?? 0;
    if (kg < 30) kg = 30;
    if (kg > 200) kg = 200;

    setState(() {
      _weightKg = kg;
      _sliderValue = kg;
    });
  }

  void _updateWeightFromSlider(double value) {
    setState(() {
      _weightKg = value;
      _sliderValue = value;
      _kgController.text = value.toStringAsFixed(0);
    });
  }

  @override
  void dispose() {
    _kgController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onBackground;

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.primaryColorDark),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Weight',
          style: TextStyle(
            color: theme.primaryColorDark,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: theme.primaryColor,
        elevation: 0,
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: textColor, size: 28),
            onPressed: () => Get.find<ThemeController>().toggleTheme(),
          ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie Animation
            Container(
              width: 200.h,
              height: 200.h,
              decoration: const BoxDecoration(shape: BoxShape.rectangle),
              child: Lottie.asset(
                'assets/animations/animation.json',
                fit: BoxFit.fill,
              ),
            ),

            Text(
              'Enter your weight in kilograms',
              style: theme.textTheme.headlineLarge?.copyWith(
                color: textColor,
                fontSize: 20.h,
              ),
              textAlign: TextAlign.center,
            ),

            SizedBox(height: 30.h),

            // Weight Input Field
            TextFormField(
              controller: _kgController,
              decoration: InputDecoration(
                labelText: 'Weight (kg)',
                border: OutlineInputBorder(),
                filled: true,
                fillColor:
                    isDark
                        ? Colors.white.withOpacity(0.1)
                        : Colors.black.withOpacity(0.05),
                labelStyle: TextStyle(color: textColor),
              ),
              keyboardType: TextInputType.number,
              style: theme.textTheme.headlineSmall?.copyWith(color: textColor),
              onChanged: (_) => _updateWeightFromInput(),
            ),

            SizedBox(height: 20.h),

            Text(
              'Weight: ${_weightKg.toStringAsFixed(1)} kg',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),

            SizedBox(height: 30.h),

            Text(
              'Adjust weight using the slider:',
              style: TextStyle(
                color: textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 20.h),

            Slider(
              value: _sliderValue,
              min: 30,
              max: 200,
              activeColor: theme.primaryColor,
              inactiveColor: textColor.withOpacity(0.4),
              onChanged: _updateWeightFromSlider,
            ),

            SizedBox(height: 30.h),

            // Submit Button
            SubmitButton(
              onPressed: () {
                String weight = _kgController.text;
                if (weight.isEmpty) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Please enter your weight.')),
                  );
                } else {
                  Get.to(
                    () => AgeScreen(height: widget.height, weight: weight),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
