import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppButton extends StatelessWidget {
  final String buttonText;
  final Color? bgColor;
  final Color? textColor;
  final Function()? onTap;
  const AppButton({super.key, required this.buttonText, this.bgColor,this.textColor, this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap:onTap ,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:bgColor?? AppColors.mainColor,
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Text(
          buttonText,
          style: AppTextStyle().hitTextStyle.copyWith(color:textColor?? Colors.white),
        ),
      ),
    );
  }
}
