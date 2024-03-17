import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/ai_bot/views/screen/chat_screen.dart';
import 'package:ai_bot/ai_bot/views/screen/image_convert_screen.dart';
import 'package:ai_bot/ai_bot/views/widgets/assistant_component.dart';
import 'package:ai_bot/ai_bot/views/widgets/custom_appbar.dart';
import 'package:ai_bot/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(elevation: 0,
        backgroundColor: AppColors.kPrimaryColor,
        onPressed: () {
          AppNavigator.appNavigator(context, const ChatScreen());
        },
        child: CircleAvatar(
          backgroundColor: Colors.transparent,
          radius: 30.sp,
          child: Image.asset('assets/images/robot2.png'),
        ),
      ),
      backgroundColor: AppColors.kbackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(16.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const CustomAppbar(),
              SizedBox(
                height: 30.h,
              ),
              Text(
                'Hello,User 👋',
                style: TextStyle(
                    fontSize: 22.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.kWhiteColor),
              ),
              SizedBox(
                height: 14.h,
              ),
              Text(
                'An Application that to convert image to text to extract text from images',
                style: TextStyle(fontSize: 12.sp, color: AppColors.kWhiteColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 120.h,
              ),
              Center(
                child: Column(
                  children: [
                    AssistantComponent(
                        containerCollor: AppColors.kWhiteColor,
                        buttonText: 'Image',
                        buttonImage: 'assets/images/gallery.png',
                        buttontextCollor: Colors.black,
                        fuunction: () {
                          AppNavigator.appNavigator(
                              context, const ImageConvertScreen());
                        }),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
