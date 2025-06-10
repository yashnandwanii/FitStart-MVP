import 'package:fit_start/widgets/auth_input.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';

import 'package:fit_start/controllers/auth_controller.dart';
import 'package:fit_start/screens/signup/signup_page.dart';
import 'package:fit_start/widgets/round_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());
  void submit() async {
    if (_formKey.currentState == null) return;

    if (_formKey.currentState!.validate()) {
      try {
        await _authController.login(
          _emailController.text.trim(),
          _passwordController.text.trim(),
        );
      } catch (e) {
        // Handle login error
        Get.snackbar(
          "Login Failed",
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white,
        );
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Logo or Illustration
                Container(
                  width: 250.w,
                  height: 250.h,
                  decoration: const BoxDecoration(shape: BoxShape.rectangle),
                  child: Lottie.asset(
                    'assets/animations/login.json', // Replace with your Lottie animation path
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  "Welcome Back!",
                  style: theme.textTheme.headlineLarge?.copyWith(fontSize: 28),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Login to continue your fitness journey",
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),

                AuthInput(
                  validator: ValidationBuilder().required().email().build(),
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  controller: _emailController,
                  icon: Icons.email_outlined,
                ),
                SizedBox(height: 20.h),

                AuthInput(
                  validator:
                      ValidationBuilder()
                          .required()
                          .minLength(6)
                          .maxLength(20)
                          .build(),
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  controller: _passwordController,
                  icon: Icons.lock_outline,
                  obscureText: true,
                ),
                SizedBox(height: 30.h),

                // Login Button
                Obx(
                  () => RoundButton(
                    onPressed: submit,
                    text:
                        _authController.loginloading.value == true
                            ? 'Loading...'
                            : 'Login',
                  ),
                ),
                SizedBox(height: 20.h),

                // Signup Prompt
                Text.rich(
                  TextSpan(
                    text: 'Don\'t have an account? ',
                    children: [
                      TextSpan(
                        text: 'Register',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.to(() => SignUpPage());
                              },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
