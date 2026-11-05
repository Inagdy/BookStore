import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EmptyCartView extends StatelessWidget {
  final VoidCallback? onRefresh;

  const EmptyCartView({super.key, this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: EdgeInsets.all(28.r),
              decoration: BoxDecoration(
                color: AppColors.mainColor.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.shopping_bag_outlined,
                size: 70.r,
                color: AppColors.mainColor,
              ),
            ),
            24.h.verticalSpace,
            Text(
              'Your cart is empty',
              style: TextStyle(
                fontSize: 22.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.backColor,
              ),
            ),
            8.h.verticalSpace,
            Text(
              'Looks like you haven\'t added any books yet.\nExplore our collection and add your favorite reads!',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grayColor,
                height: 1.4,
              ),
            ),
            if (onRefresh != null) ...[
              28.h.verticalSpace,
              SizedBox(
                width: 180.w,
                child: AppButton(
                  buttonText: 'Refresh',
                  onTap: onRefresh,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
