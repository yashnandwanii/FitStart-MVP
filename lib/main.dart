import 'package:fit_start/services/supabase_services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // ✅

import 'package:fit_start/screens/splash_screen.dart';
import 'package:fit_start/theme/theme_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await GetStorage.init();
  Get.put(SupabaseServices());
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeController _themeController = Get.put(ThemeController());
  MyApp({super.key});
  final supabase = Supabase.instance.client;
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GetMaterialApp(
          title: 'Fit Start',
          debugShowCheckedModeBanner: false,
          theme: _themeController.currentTheme,
          home: StartupView(),
        );
      },
    );
  }
}
