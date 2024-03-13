import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class PickerButton extends StatelessWidget {
  var function;
  String text;
  bool isFirst = true, isChatButton;
  PickerButton(
      {super.key,
      required this.function,
      required this.text,
      this.isFirst = true,
      this.isChatButton = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          color: isChatButton ? AppColors.kbackgroundColor : AppColors.kPrimaryColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isFirst == true ? 0.sp : 8.sp),
              topRight: Radius.circular(isFirst == true ? 8.sp : 0.sp)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kSecondaryColor),
          ),
        ),
      ),
    );
  }
}
