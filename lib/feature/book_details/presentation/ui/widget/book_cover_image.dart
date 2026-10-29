import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookCoverImage extends StatelessWidget {
  final String? imageUrl;
  final bool isBestSeller;
  final int? discount;

  const BookCoverImage({
    super.key,
    this.imageUrl,
    this.isBestSeller = false,
    this.discount,
  });

  @override
  Widget build(BuildContext context) {
    final hasDiscount = (discount != null && discount! > 0);
    final url = imageUrl ?? '';

    return Center(
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Container(
            width: 175.w,
            height: 250.h,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              boxShadow: [
                BoxShadow(
                  color: AppColors.backColor.withValues(alpha: 0.18),
                  blurRadius: 26,
                  spreadRadius: 2,
                  offset: const Offset(0, 14),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16.r),
              child: url.isNotEmpty
                  ? Image.network(
                      url,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const BookCoverPlaceholder(),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          color: Colors.grey.shade200,
                          child: Center(
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: AppColors.mainColor,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          ),
                        );
                      },
                    )
                  : const BookCoverPlaceholder(),
            ),
          ),
          if (isBestSeller)
            Positioned(
              top: 10.h,
              left: -8.w,
              child: const BestSellerBadge(),
            ),
          if (hasDiscount)
            Positioned(
              top: 10.h,
              right: -8.w,
              child: DiscountBadge(discount: discount!),
            ),
        ],
      ),
    );
  }
}

class BookCoverPlaceholder extends StatelessWidget {
  const BookCoverPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.grey.shade200,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.menu_book_rounded,
            size: 48.sp,
            color: AppColors.grayColor,
          ),
          8.verticalSpace,
          Text(
            'Book Cover',
            style: TextStyle(
              fontSize: 12.sp,
              color: AppColors.grayColor,
            ),
          ),
        ],
      ),
    );
  }
}

class BestSellerBadge extends StatelessWidget {
  const BestSellerBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.mainColor.withValues(alpha: 0.4),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.star_rounded, size: 14.sp, color: Colors.white),
          4.horizontalSpace,
          Text(
            'BEST SELLER',
            style: TextStyle(
              fontSize: 10.sp,
              fontWeight: FontWeight.w700,
              color: Colors.white,
              letterSpacing: 0.5,
            ),
          ),
        ],
      ),
    );
  }
}

class DiscountBadge extends StatelessWidget {
  final int discount;

  const DiscountBadge({super.key, required this.discount});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: const Color(0xffE53935),
        borderRadius: BorderRadius.circular(20.r),
        boxShadow: [
          BoxShadow(
            color: const Color(0xffE53935).withValues(alpha: 0.35),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        '-$discount%',
        style: TextStyle(
          fontSize: 11.sp,
          fontWeight: FontWeight.w700,
          color: Colors.white,
        ),
      ),
    );
  }
}

