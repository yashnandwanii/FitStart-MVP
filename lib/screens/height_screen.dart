// ignore_for_file: deprecated_member_use

import 'package:fit_start/screens/weight_screen.dart';
import 'package:fit_start/theme/theme_controller.dart';
import 'package:fit_start/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

class HeightScreen extends StatefulWidget {
  const HeightScreen({super.key});

  @override
  State<HeightScreen> createState() => _HeightScreenState();
}

class _HeightScreenState extends State<HeightScreen> {
  final TextEditingController _feetController = TextEditingController();
  final TextEditingController _inchesController = TextEditingController();
  double _heightCm = 160;
  String _heightInFeetInches = '5\' 3"';
  double _sliderValue = 160.0;
  var height = '160';

  @override
  void initState() {
    super.initState();
    // Initialize feet and inches based on default cm height
    _setFeetInchesFromCm(_heightCm);
  }

  void _setFeetInchesFromCm(double cm) {
    int feet = (cm / 30.48).floor();
    int inches = ((cm / 2.54) % 12).round();

    // Normalize inches if it is 12 or more
    if (inches == 12) {
      feet += 1;
      inches = 0;
    }

    _feetController.text = feet.toString();
    _inchesController.text = inches.toString();
    _heightInFeetInches = '${feet}\' ${inches}"';
    _sliderValue = cm;
    height = cm.toStringAsFixed(0);
  }

  void _calculateHeightFromFeetInches() {
    double feet = double.tryParse(_feetController.text) ?? 0;
    double inches = double.tryParse(_inchesController.text) ?? 0;

    // Normalize inches
    if (inches >= 12) {
      feet += (inches / 12).floor();
      inches = inches % 12;
    }

    double calculatedCm = (feet * 30.48) + (inches * 2.54);

    // Check if height is within valid range for the slider
    if (calculatedCm < 100 || calculatedCm > 220) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            "Please enter a valid height between 100 cm and 220 cm.",
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: Colors.redAccent,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      );
      return;
    }

    setState(() {
      _heightCm = calculatedCm;
      _heightInFeetInches = '${feet.toInt()}\' ${inches.toInt()}"';
      _sliderValue = _heightCm;
      height = _heightCm.toStringAsFixed(0);
    });
  }

  void _updateHeightFromSlider(double value) {
    _heightCm = value;

    int feet = (_heightCm / 30.48).floor();
    int inches = ((_heightCm / 2.54) % 12).round();

    // Normalize inches if needed
    if (inches == 12) {
      feet += 1;
      inches = 0;
    }

    _heightInFeetInches = '${feet}\' ${inches}"';

    setState(() {
      _feetController.text = feet.toString();
      _inchesController.text = inches.toString();
      _sliderValue = value;
      height = _heightCm.toStringAsFixed(0);
    });
  }

  @override
  void dispose() {
    _feetController.dispose();
    _inchesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = theme.colorScheme.onBackground;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Height',
          style: TextStyle(
            color: theme.primaryColorDark,
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.brightness_6, color: textColor, size: 28),
            onPressed: () => Get.find<ThemeController>().toggleTheme(),
          ),
        ],
        centerTitle: true,
        backgroundColor: Theme.of(context).primaryColor, // FitStart Green
        elevation: 0, // Removes the shadow under the AppBar
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 20.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
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
              Text(
                'Enter your height',
                style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: textColor,
                  fontSize: 24,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 30.h),
              TextFormField(
                controller: _feetController,
                decoration: InputDecoration(
                  labelText: 'Feet',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor:
                      Theme.of(context).brightness == Brightness.dark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),

                  labelStyle: TextStyle(color: textColor),
                ),
                keyboardType: TextInputType.number,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: textColor,
                ),
                onChanged: (_) => _calculateHeightFromFeetInches(),
              ),
              SizedBox(height: 20.h),

              TextFormField(
                controller: _inchesController,
                decoration: InputDecoration(
                  labelText: 'Inches',
                  border: OutlineInputBorder(),
                  filled: true,
                  fillColor:
                      isDark
                          ? Colors.white.withOpacity(0.1)
                          : Colors.black.withOpacity(0.05),
                  labelStyle: TextStyle(color: textColor),
                ),
                keyboardType: TextInputType.number,
                style: theme.textTheme.headlineSmall?.copyWith(
                  color: textColor,
                ),
                onChanged: (_) => _calculateHeightFromFeetInches(),
              ),
              SizedBox(height: 20.h),
              Text(
                'Height: $_heightInFeetInches\n(${_heightCm.toStringAsFixed(0)} cm)',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: textColor,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 20.h),
              Text(
                'Adjust height using the slider:',
                style: TextStyle(
                  color: textColor,
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20.h),
              Slider(
                value: _sliderValue,
                min: 100,
                max: 220,
                activeColor: theme.primaryColor,
                inactiveColor: textColor.withOpacity(0.4),
                onChanged: _updateHeightFromSlider,
              ),
              const SizedBox(height: 20),

              // Submit Button with Styling
              SubmitButton(
                onPressed: () {
                  debugPrint('Height in cm: $height');
                  Get.to(
                    () => WeightScreen(height: height),
                    transition: Transition.rightToLeft,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeInOut,
                  ); // Navigate to WeightScreen
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
