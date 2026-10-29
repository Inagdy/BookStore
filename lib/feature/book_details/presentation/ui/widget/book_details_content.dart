import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/book_details/data/model/book_detials_model.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_bottom_action_bar.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_cover_image.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_description_section.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_details_app_bar.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_rating_row.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_stats_row.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsContent extends StatelessWidget {
  final Data book;
  final bool isBookmarked;
  final VoidCallback onBookmarkTap;
  final void Function(int quantity) onAddToCart;
  final VoidCallback? onBackTap;

  const BookDetailsContent({
    super.key,
    required this.book,
    required this.isBookmarked,
    required this.onBookmarkTap,
    required this.onAddToCart,
    this.onBackTap,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              BookDetailsAppBar(
                isBookmarked: isBookmarked,
                onBookmarkTap: onBookmarkTap,
                onBackTap: onBackTap,
              ),
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  padding: EdgeInsets.only(
                    left: 20.w,
                    right: 20.w,
                    top: 10.h,
                    bottom: 120.h,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      BookCoverImage(
                        imageUrl: book.image,
                        isBestSeller: book.bestSeller == 1,
                        discount: book.discount,
                      ),
                      24.verticalSpace,
                      Text(
                        book.name ?? 'Untitled',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.backColor,
                          height: 1.3,
                        ),
                      ),
                      8.verticalSpace,
                      if (book.category != null && book.category!.isNotEmpty)
                        Text(
                          book.category!,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                            color: AppColors.mainColor,
                            letterSpacing: 0.5,
                          ),
                        ),
                      12.verticalSpace,
                      const BookRatingRow(),
                      20.verticalSpace,
                      BookStatsRow(
                        category: book.category,
                        stock: book.stock,
                      ),
                      24.verticalSpace,
                      BookDescriptionSection(
                        description: book.description,
                      ),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: BookBottomActionBar(
            price: book.price,
            priceAfterDiscount: book.priceAfterDiscount,
            discount: book.discount,
            stock: book.stock,
            onAddToCart: onAddToCart,
          ),
        ),
      ],
    );
  }
}

