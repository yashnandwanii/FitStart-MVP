import 'package:fit_start/controllers/auth_controller.dart';
import 'package:fit_start/widgets/auth_input.dart';
import 'package:fit_start/widgets/round_button.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:form_validator/form_validator.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final AuthController _authController = Get.put(AuthController());

  void register() {
    if (_formKey.currentState!.validate()) {
      debugPrint('Calling Registration');
      _authController.register(
        _nameController.text,
        _emailController.text,
        _passwordController.text,
      );
    }
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: 20.h, vertical: 40.h),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 250.w,
                  height: 250.h,
                  child: Lottie.asset(
                    'assets/animations/login.json',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20.h),
                Text(
                  "Create Account",
                  style: theme.textTheme.headlineLarge?.copyWith(fontSize: 28),
                ),
                SizedBox(height: 8.h),
                Text(
                  "Join us and start your fitness journey!",
                  style: theme.textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),

                AuthInput(
                  validator:
                      ValidationBuilder()
                          .required()
                          .minLength(3)
                          .maxLength(20)
                          .build(),
                  controller: _nameController,
                  hintText: 'Enter your Name',
                  labelText: 'Name',
                  icon: Icons.person_outline,
                ),
                SizedBox(height: 20.h),

                // Email
                AuthInput(
                  validator: ValidationBuilder().required().email().build(),
                  controller: _emailController,
                  hintText: 'Enter your email',
                  labelText: 'Email',
                  icon: Icons.email_outlined,
                ),
                SizedBox(height: 20.h),

                // Password
                AuthInput(
                  validator:
                      ValidationBuilder()
                          .required()
                          .minLength(6)
                          .maxLength(20)
                          .build(),
                  controller: _passwordController,
                  hintText: 'Enter your password',
                  labelText: 'Password',
                  obscureText: true,
                  icon: Icons.lock_outline,
                ),
                SizedBox(height: 30.h),

                // Sign Up Button
                Obx(
                  () => RoundButton(
                    onPressed: register,
                    text:
                        _authController.loginloading.value == true
                            ? 'Loading...'
                            : 'Sign Up',
                  ),
                ),
                SizedBox(height: 20.h),

                Text.rich(
                  TextSpan(
                    text: 'Already have an account? ',
                    children: [
                      TextSpan(
                        text: 'Login',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                        ),
                        recognizer:
                            TapGestureRecognizer()
                              ..onTap = () {
                                Get.back();
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
