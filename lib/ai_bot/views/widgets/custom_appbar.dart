import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 20.sp,
          backgroundImage: const AssetImage('assets/images/robot.png'),
        ),
        SizedBox(
          width: 80.w,
        ),
        Text(
          'Home Page',
          style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
        ),
       
      ],
    );
  }
}
