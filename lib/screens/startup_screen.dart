import 'package:fit_start/screens/login/login_page.dart';
import 'package:fit_start/screens/signup/signup_page.dart';
import 'package:fit_start/theme/theme_controller.dart';
import 'package:fit_start/widgets/round_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WelcomeView extends StatefulWidget {
  const WelcomeView({super.key});

  @override
  State<WelcomeView> createState() => _WelcomeViewState();
}

class _WelcomeViewState extends State<WelcomeView> {
  final ThemeController themeController = Get.put(ThemeController());
  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: media.width,
            height: media.height * 0.4,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/images/ic_launcher.png'),
                fit: BoxFit.contain,
                alignment: Alignment.center,
              ),
            ),
          ),
          SizedBox(height: media.height * 0.05),
          Text(
            'Welcome to Fit Start',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Theme.of(context).primaryColor,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: media.height * 0.05),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RoundButton(
              onPressed: () {
                Get.to(() => LoginPage(), transition: Transition.rightToLeft);
              },
              text: 'Log In',
            ),
          ),
          SizedBox(height: media.height * 0.02),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25),
            child: RoundButton(
              onPressed: () {
                Get.to(() => SignUpPage(), transition: Transition.rightToLeft);
              },
              type: RoundButtonType.textPrimary,
              text: 'Create an Account',
            ),
          ),
        ],
      ),
    );
  }
}
