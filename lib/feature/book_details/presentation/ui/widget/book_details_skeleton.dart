import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_bottom_action_bar.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_cover_image.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_description_section.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_details_app_bar.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_rating_row.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_stats_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailsSkeleton extends StatelessWidget {
  const BookDetailsSkeleton({super.key});

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xffE6E8EB),
        highlightColor: Color(0xffF7F8F9),
      ),
      child: Stack(
        children: [
          SafeArea(
            bottom: false,
            child: Column(
              children: [
                BookDetailsAppBar(
                  isBookmarked: false,
                  onBookmarkTap: () {},
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.only(
                      left: 20.w,
                      right: 20.w,
                      top: 10.h,
                      bottom: 120.h,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const BookCoverImage(
                          imageUrl: '',
                          isBestSeller: true,
                          discount: 15,
                        ),
                        24.verticalSpace,
                        Text(
                          'Sample Book Title In Shimmer',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 22.sp,
                            fontWeight: FontWeight.w700,
                            color: AppColors.backColor,
                          ),
                        ),
                        8.verticalSpace,
                        Text(
                          'General Category',
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                          ),
                        ),
                        12.verticalSpace,
                        const BookRatingRow(),
                        20.verticalSpace,
                        const BookStatsRow(
                          category: 'General',
                          stock: 10,
                        ),
                        24.verticalSpace,
                        const BookDescriptionSection(
                          description:
                              'This is placeholder description text rendered in skeleton mode while loading the actual book details.',
                        ),
                        24.verticalSpace,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: BookBottomActionBar(
              price: '\$99.00',
              priceAfterDiscount: 84.15,
              discount: 15,
              stock: 10,
            ),
          ),
        ],
      ),
    );
  }
}

