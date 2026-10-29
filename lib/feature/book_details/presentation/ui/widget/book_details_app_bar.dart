import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/circle_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsAppBar extends StatelessWidget {
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final VoidCallback? onBackTap;

  const BookDetailsAppBar({
    super.key,
    required this.isBookmarked,
    required this.onBookmarkTap,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: onBackTap ?? () => Navigator.of(context).pop(),
          ),
          Text(
            'Book Details',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.backColor,
            ),
          ),
          CircleIconButton(
            icon: isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            iconColor: isBookmarked ? AppColors.mainColor : AppColors.backColor,
            onTap: onBookmarkTap,
          ),
        ],
      ),
    );
  }
}

