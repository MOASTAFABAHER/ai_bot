import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/ai_bot/views/screen/chat_screen.dart';
import 'package:ai_bot/ai_bot/views/screen/image_convert_screen.dart';
import 'package:ai_bot/ai_bot/views/screen/speech_to_text_screen.dart';
import 'package:ai_bot/ai_bot/views/widgets/assistant_component.dart';
import 'package:ai_bot/ai_bot/views/widgets/custom_appbar.dart';
import 'package:ai_bot/utils/app_navigator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                height: 10.h,
              ),
              Text(
                'Welcome to AI assistant',
                style: TextStyle(fontSize: 12.sp, color: AppColors.kGreyColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Features',
                style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 40.h,
              ),
              Row(
                children: [
                  AssistantComponent(
                      containerCollor: const Color(0xffdc6b5a),
                      mainText: 'Explore speech Recognition',
                      mainTextCollor: AppColors.kWhiteColor,
                      secondText: 'I\'m Listening 👂',
                      subTextColor: const Color(0xffefbcb5),
                      buttonText: 'Voice',
                      buttonImage: 'assets/images/microphone.png',
                      fuunction: () {
                        AppNavigator.appNavigator(
                            context, const SpeechToTextScreen());
                      }),
                  SizedBox(
                    width: 25.w,
                  ),
                  AssistantComponent(
                      containerCollor: const Color(0xff5b86eb),
                      mainText: 'Haw can I help you ❔',
                      mainTextCollor: AppColors.kWhiteColor,
                      secondText: 'Texting With AI 🤖',
                      subTextColor: const Color(0xff8eacf1),
                      buttonText: 'Text',
                      buttonImage: 'assets/images/chat.png',
                      fuunction: () {
                        AppNavigator.appNavigator(context, const ChatScreen());
                      }),
                ],
              ),
              SizedBox(
                height: 25.h,
              ),
              AssistantComponent(
                  containerCollor: const Color(0xffffd971),
                  mainText: 'Transform an image to text ',
                  mainTextCollor: const Color(0xff0c0a05),
                  secondText: 'Convert image ',
                  subTextColor: const Color(0xffbda859),
                  buttonText: 'Image',
                  buttonImage: 'assets/images/gallery.png',
                  buttontextCollor: Colors.black,
                  fuunction: () {
                    AppNavigator.appNavigator(context, ImageConvertScreen());
                  }),
            ],
          ),
        ),
      ),
    );
  }
}
