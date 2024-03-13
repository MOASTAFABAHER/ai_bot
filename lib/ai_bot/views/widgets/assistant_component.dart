import 'dart:io';

import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class AssistantComponent extends StatelessWidget {
  var fuunction,
      containerCollor,
      mainTextCollor,
      subTextColor,
      buttontextCollor;
  String mainText, secondText, buttonImage, buttonText;
  AssistantComponent(
      {super.key,
      required this.mainText,
      required this.secondText,
      required this.buttonImage,
      required this.buttonText,
      required this.fuunction,
      required this.containerCollor,
      required this.mainTextCollor,
      this.buttontextCollor,
      required this.subTextColor});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: fuunction,
      child: Container(
        padding: EdgeInsets.all(8.sp),
        width: 140.w,
        height: MediaQuery.sizeOf(context).height > 1000
            ? 160.h
            : 140.h, //to know if they tablet or not to fix overflow
        decoration: BoxDecoration(
          color: containerCollor,
          borderRadius: BorderRadius.circular(15.sp),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.0.sp),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                mainText,
                style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: mainTextCollor),
              ),
              SizedBox(
                height: 5.h,
              ),
              Text(
                secondText,
                style: TextStyle(fontSize: 10.sp, color: subTextColor),
              ),
              SizedBox(
                height: 20.h,
              ),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(8.sp),
                    width: 40.w,
                    height: 40.h,
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
