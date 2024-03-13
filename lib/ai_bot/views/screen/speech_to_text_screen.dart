import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:ai_bot/bloc/voice/voice_cubit.dart';
import 'package:ai_bot/config/toast_config.dart';
import 'package:ai_bot/enums/toast_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:speech_to_text/speech_to_text.dart';

class SpeechToTextScreen extends StatefulWidget {
  const SpeechToTextScreen({super.key});

  @override
  State<SpeechToTextScreen> createState() => _SpeechToTextScreenState();
}

class _SpeechToTextScreenState extends State<SpeechToTextScreen> {
  @override
  void initState() {
    // TODO: implement initState
    VoiceCubit.get(context).isListing=false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<VoiceCubit, VoiceState>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = VoiceCubit.get(context);
        return Scaffold(
          backgroundColor: AppColors.kbackgroundColor,
          body: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Expanded(child: SelectableText(cubit.recognizedText)),
                    GestureDetector(
                      onTap: () {
                        ToastConfig.showToast(
                            msg: 'Copied', toastStates: ToastStates.Success);
                        Clipboard.setData(
                            ClipboardData(text: cubit.recognizedText));
                      },
                      child: Image.asset(
                        'assets/images/copy.png',
                        color: AppColors.kWhiteColor,
                        height: 20.h,
                        width: 20.w,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 20.h,
                ),
                Center(
                  child: GestureDetector(
                    onTap: () {
                      cubit.isListing
                          ? cubit.startRecording()
                          : cubit.startRecording();
                    },
                    child: CircleAvatar(
                      radius: 60.sp,
                      backgroundColor: AppColors.kPrimaryColor,
                      child: Padding(
                        padding: EdgeInsets.all(16.sp),
                        child: Icon(
                          cubit.isListing ? Icons.stop : Icons.mic,
                          size: 70.sp,
                          color: AppColors.kBlackColor,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
