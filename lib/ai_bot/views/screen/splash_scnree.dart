import 'dart:async';

import 'package:ai_bot/ai_bot/views/screen/home_screen.dart';
import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(
      const Duration(seconds: 3),
      () {
        // Navigate to the main screen after the splash screen
        AppNavigator.appNavigator(context, const HomeScreen(),
            isFinished: true);
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.kbackgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/robot.png'),
            SizedBox(
              height: 30.h,
            ),
            Text(
              'My robot',
              style: TextStyle(
                  fontSize: 18.sp,
                  color: AppColors.kWhiteColor,
                  fontWeight: FontWeight.bold),
            )
          ],
        ),
      ),
    );
  }
}
