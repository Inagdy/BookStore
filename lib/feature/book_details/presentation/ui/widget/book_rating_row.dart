import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookRatingRow extends StatelessWidget {
  final double rating;
  final int reviewCount;

  const BookRatingRow({
    super.key,
    this.rating = 4.5,
    this.reviewCount = 128,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            index < rating.floor()
                ? Icons.star_rounded
                : (index < rating
                    ? Icons.star_half_rounded
                    : Icons.star_border_rounded),
            color: const Color(0xffFFB800),
            size: 18.sp,
          ),
        ),
        8.horizontalSpace,
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.backColor,
          ),
        ),
        4.horizontalSpace,
        Text(
          '($reviewCount reviews)',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.grayColor,
          ),
        ),
      ],
    );
  }
}

