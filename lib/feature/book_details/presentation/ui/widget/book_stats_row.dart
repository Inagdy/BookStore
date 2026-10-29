import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookStatsRow extends StatelessWidget {
  final String? category;
  final int? stock;
  final String language;

  const BookStatsRow({
    super.key,
    this.category,
    this.stock,
    this.language = 'English',
  });

  @override
  Widget build(BuildContext context) {
    final availableStock = stock ?? 0;
    final inStock = availableStock > 0;

    return Container(
      padding: EdgeInsets.symmetric(vertical: 14.h, horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          BookStatItem(
            icon: Icons.auto_stories_outlined,
            title: 'Genre',
            value: (category != null && category!.isNotEmpty)
                ? category!
                : 'General',
          ),
          const StatDivider(),
          BookStatItem(
            icon: Icons.inventory_2_outlined,
            title: 'Stock',
            value: inStock ? '$availableStock Left' : 'Out of Stock',
            valueColor: inStock
                ? const Color(0xff2E7D32)
                : const Color(0xffC62828),
          ),
          const StatDivider(),
          BookStatItem(
            icon: Icons.translate_rounded,
            title: 'Language',
            value: language,
          ),
        ],
      ),
    );
  }
}

class BookStatItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? valueColor;

  const BookStatItem({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.valueColor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, size: 20.sp, color: AppColors.mainColor),
          6.verticalSpace,
          Text(
            title,
            style: TextStyle(
              fontSize: 11.sp,
              color: AppColors.grayColor,
              fontWeight: FontWeight.w500,
            ),
          ),
          4.verticalSpace,
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 12.sp,
              fontWeight: FontWeight.w700,
              color: valueColor ?? AppColors.backColor,
            ),
          ),
        ],
      ),
    );
  }
}

class StatDivider extends StatelessWidget {
  const StatDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32.h,
      color: AppColors.borderColor,
    );
  }
}

