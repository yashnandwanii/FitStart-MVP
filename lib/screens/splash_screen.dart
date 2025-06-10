import 'package:fit_start/screens/height_screen.dart';
import 'package:fit_start/screens/startup_screen.dart';
import 'package:fit_start/services/storage_services.dart';
import 'package:flutter/material.dart';

import 'package:page_transition/page_transition.dart';

class StartupView extends StatefulWidget {
  const StartupView({super.key});

  @override
  State<StartupView> createState() => _StartupViewState();
}

class _StartupViewState extends State<StartupView> {
  @override
  void initState() {
    super.initState();
    goWelcomePage();
  }

  void goWelcomePage() async {
    await Future.delayed(const Duration(seconds: 2));
    debugPrint('Checking user session...');

    StorageServices.userSession != null ? HeightScreen() : welcomePage();
    if (StorageServices.userSession != null) {
      debugPrint('User session found, navigating to HeightScreen...');
      // ignore: use_build_context_synchronously
      context.pushReplacementTransition(
        type: PageTransitionType.bottomToTop,
        duration: const Duration(milliseconds: 500),
        child: const HeightScreen(),
      );
    } else {
      debugPrint('No user session found, navigating to WelcomeView...');
      welcomePage();
    }
  }

  void welcomePage() {
    context.pushReplacementTransition(
      type: PageTransitionType.bottomToTop,
      duration: const Duration(milliseconds: 500),
      child: const WelcomeView(),
    );
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            width: media.width,
            height: media.height,
            color: Theme.of(context).primaryColorDark,
          ),
          Image.asset(
            'assets/images/ic_launcher.png',
            width: media.width * 0.7,
            height: media.height * 0.7,
            fit: BoxFit.contain,
          ),
        ],
      ),
    );
  }
}
