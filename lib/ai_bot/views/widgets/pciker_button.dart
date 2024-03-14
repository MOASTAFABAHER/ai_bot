import 'package:ai_bot/ai_bot/constants/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class PickerButton extends StatelessWidget {
  var function;
  String text;
  bool isCahtbutton;

  PickerButton({
    super.key,
    required this.function,
    required this.text,
    this.isCahtbutton = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: function,
      child: Container(
        width: double.infinity,
        height: 40.h,
        decoration: BoxDecoration(
          color:
              isCahtbutton ? AppColors.kWhiteColor : AppColors.kbackgroundColor,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(isCahtbutton ? 8.sp : 0.sp),
              topRight: Radius.circular(isCahtbutton ? 8.sp : 0.sp)),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.kSecondaryColor),
          ),
        ),
      ),
    );
  }
}
