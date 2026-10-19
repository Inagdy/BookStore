import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BackwordButton extends StatelessWidget {
  const BackwordButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 41.0.w,
      height: 41.0.h,
      decoration: BoxDecoration(
        color: const Color(0xFFFFFFFF),
        borderRadius: BorderRadius.circular(12.r),
      ),

      child: IconButton(
        onPressed: () {
          Navigator.pop(context);
        },
        icon: Icon(
          Icons.arrow_back_ios_new_outlined,
          color: AppColors.mainColor,
        ),
      ),
    );
  }
}
