import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsErrorView extends StatelessWidget {
  final String title;
  final String message;
  final VoidCallback onRetry;
  final VoidCallback? onBackTap;

  const BookDetailsErrorView({
    super.key,
    required this.title,
    required this.message,
    required this.onRetry,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                CircleIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: onBackTap ?? () => Navigator.of(context).pop(),
                ),
              ],
            ),
          ),
          Expanded(
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 32.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 80.w,
                      height: 80.h,
                      decoration: BoxDecoration(
                        color: AppColors.mainColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.cloud_off_rounded,
                        size: 40.sp,
                        color: AppColors.mainColor,
                      ),
                    ),
                    20.verticalSpace,
                    Text(
                      title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 20.sp,
                        fontWeight: FontWeight.w700,
                        color: AppColors.backColor,
                      ),
                    ),
                    8.verticalSpace,
                    Text(
                      message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.grayColor,
                        height: 1.4,
                      ),
                    ),
                    24.verticalSpace,
                    SizedBox(
                      width: 150.w,
                      height: 44.h,
                      child: ElevatedButton.icon(
                        onPressed: onRetry,
                        icon: const Icon(Icons.refresh_rounded, color: Colors.white),
                        label: const Text(
                          'Try Again',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.mainColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                          elevation: 0,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

