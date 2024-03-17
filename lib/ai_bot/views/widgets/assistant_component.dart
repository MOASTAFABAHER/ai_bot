
import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AssistantComponent extends StatelessWidget {
  var fuunction, containerCollor, buttontextCollor;
  String buttonImage, buttonText;
  AssistantComponent({
    super.key,
    required this.buttonImage,
    required this.buttonText,
    required this.fuunction,
    required this.containerCollor,
    this.buttontextCollor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fuunction,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        width: 140.w,
        height: MediaQuery.sizeOf(context).height > 1000
            ? 110.h
            : 80.h, //to know if they tablet or not to fix overflow
        decoration: BoxDecoration(
            color: containerCollor, borderRadius: BorderRadius.circular(5.sp)),
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    width: 50.w,
                    height: 50.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.sp),
                      color: buttontextCollor ?? AppColors.kWhiteColor,
                    ),
                    child: Image.asset(
                      buttonImage,
                      color: buttontextCollor == null
                          ? AppColors.kBlackColor
                          : AppColors.kWhiteColor,
                    ),
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  Text(
                    buttonText,
                    style: TextStyle(
                      fontSize: 14.sp,
                      fontWeight: FontWeight.bold,
                      color: buttontextCollor ?? AppColors.kWhiteColor,
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
