import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/book_details/data/model/book_detials_model.dart';
import 'package:bookkia/feature/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:skeletonizer/skeletonizer.dart';

class BookDetailsScreen extends StatefulWidget {
  final int? bookId;

  const BookDetailsScreen({super.key, this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  int _quantity = 1;
  bool _isBookmarked = false;
  bool _isDescriptionExpanded = false;

  int? get _resolvedBookId {
    if (widget.bookId != null) return widget.bookId;
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is int) return args;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: BlocBuilder<BookDetailsCubit, BookDetailsState>(
        builder: (context, state) {
          if (state is GetbookDetailsLoading) {
            return _buildSkeletonView();
          } else if (state is GetbookDetailsSucces) {
            final book = state.details.data;
            if (book == null) {
              return _buildErrorView(
                title: 'Book Not Found',
                message: 'Could not load details for this book.',
              );
            }
            return _buildDetailsContent(book);
          } else {
            return _buildErrorView(
              title: 'Something went wrong',
              message: 'Failed to load book details. Please check your connection.',
            );
          }
        },
      ),
    );
  }

  Widget _buildDetailsContent(Data book) {
    final hasDiscount = (book.discount != null && book.discount! > 0);
    final inStock = (book.stock == null || book.stock! > 0);
    final maxStock = book.stock ?? 99;

    return Stack(
      children: [
        SafeArea(
          bottom: false,
          child: Column(
            children: [
              _buildTopAppBar(book),
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
                      // Book Cover
                      _buildBookCover(book),
                      24.verticalSpace,

                      // Title
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

                      // Category
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

                      // Rating preview
                      _buildRatingRow(),
                      20.verticalSpace,

                      // Quick Stats Row
                      _buildStatsRow(book),
                      24.verticalSpace,

                      // Description Section
                      _buildDescriptionSection(book.description),
                      24.verticalSpace,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        // Bottom Sticky Action Bar
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: _buildBottomActionBar(
            book: book,
            hasDiscount: hasDiscount,
            inStock: inStock,
            maxStock: maxStock,
          ),
        ),
      ],
    );
  }

  // --- Top Navigation Bar ---
  Widget _buildTopAppBar(Data? book) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildCircleIconButton(
            icon: Icons.arrow_back_ios_new_rounded,
            onTap: () => Navigator.of(context).pop(),
          ),
          Text(
            'Book Details',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.backColor,
            ),
          ),
          _buildCircleIconButton(
            icon: _isBookmarked
                ? Icons.bookmark_rounded
                : Icons.bookmark_border_rounded,
            iconColor: _isBookmarked ? AppColors.mainColor : AppColors.backColor,
            onTap: () {
              setState(() {
                _isBookmarked = !_isBookmarked;
              });
              _showSnackBar(
                _isBookmarked
                    ? 'Saved "${book?.name ?? 'Book'}" to your wishlist!'
                    : 'Removed from wishlist',
                icon: _isBookmarked
                    ? Icons.bookmark_added_rounded
                    : Icons.bookmark_remove_rounded,
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildCircleIconButton({
    required IconData icon,
    required VoidCallback onTap,
    Color? iconColor,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Container(
          width: 42.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(color: AppColors.borderColor, width: 1),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.04),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: Icon(
            icon,
            size: 20.sp,
            color: iconColor ?? AppColors.backColor,
          ),
        ),
      ),
    );
  }

  // --- Book Cover ---
  Widget _buildBookCover(Data book) {
    final hasDiscount = (book.discount != null && book.discount! > 0);
    final isBestSeller = (book.bestSeller == 1);
    final imageUrl = book.image ?? '';

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
              child: imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _buildCoverPlaceholder(),
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
                  : _buildCoverPlaceholder(),
            ),
          ),

          // Badges
          if (isBestSeller)
            Positioned(
              top: 10.h,
              left: -8.w,
              child: Container(
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
              ),
            ),

          if (hasDiscount)
            Positioned(
              top: 10.h,
              right: -8.w,
              child: Container(
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
                  '-${book.discount}%',
                  style: TextStyle(
                    fontSize: 11.sp,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildCoverPlaceholder() {
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

  // --- Rating Row ---
  Widget _buildRatingRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ...List.generate(
          5,
          (index) => Icon(
            index < 4 ? Icons.star_rounded : Icons.star_half_rounded,
            color: const Color(0xffFFB800),
            size: 18.sp,
          ),
        ),
        8.horizontalSpace,
        Text(
          '4.5',
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.w700,
            color: AppColors.backColor,
          ),
        ),
        4.horizontalSpace,
        Text(
          '(128 reviews)',
          style: TextStyle(
            fontSize: 12.sp,
            color: AppColors.grayColor,
          ),
        ),
      ],
    );
  }

  // --- Quick Stats Row ---
  Widget _buildStatsRow(Data book) {
    final stock = book.stock ?? 0;
    final inStock = stock > 0;

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
          _buildStatItem(
            icon: Icons.auto_stories_outlined,
            title: 'Genre',
            value: (book.category != null && book.category!.isNotEmpty)
                ? book.category!
                : 'General',
          ),
          _buildStatDivider(),
          _buildStatItem(
            icon: Icons.inventory_2_outlined,
            title: 'Stock',
            value: inStock ? '$stock Left' : 'Out of Stock',
            valueColor: inStock ? const Color(0xff2E7D32) : const Color(0xffC62828),
          ),
          _buildStatDivider(),
          _buildStatItem(
            icon: Icons.translate_rounded,
            title: 'Language',
            value: 'English',
          ),
        ],
      ),
    );
  }

  Widget _buildStatDivider() {
    return Container(
      width: 1,
      height: 32.h,
      color: AppColors.borderColor,
    );
  }

  Widget _buildStatItem({
    required IconData icon,
    required String title,
    required String value,
    Color? valueColor,
  }) {
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

  // --- Description Section ---
  Widget _buildDescriptionSection(String? description) {
    final text = (description != null && description.trim().isNotEmpty)
        ? description.trim()
        : 'No description provided for this book.';
    final isLongText = text.length > 160;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(18.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Overview',
            style: TextStyle(
              fontSize: 16.sp,
              fontWeight: FontWeight.w700,
              color: AppColors.backColor,
            ),
          ),
          10.verticalSpace,
          AnimatedCrossFade(
            duration: const Duration(milliseconds: 250),
            crossFadeState: _isDescriptionExpanded || !isLongText
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            firstChild: Text(
              text,
              maxLines: 4,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: AppColors.darkGreyColor,
              ),
            ),
            secondChild: Text(
              text,
              style: TextStyle(
                fontSize: 14.sp,
                height: 1.6,
                color: AppColors.darkGreyColor,
              ),
            ),
          ),
          if (isLongText) ...[
            8.verticalSpace,
            InkWell(
              onTap: () {
                setState(() {
                  _isDescriptionExpanded = !_isDescriptionExpanded;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isDescriptionExpanded ? 'Read Less' : 'Read More',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainColor,
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(
                    _isDescriptionExpanded
                        ? Icons.keyboard_arrow_up_rounded
                        : Icons.keyboard_arrow_down_rounded,
                    size: 18.sp,
                    color: AppColors.mainColor,
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }

  // --- Sticky Bottom Bar ---
  Widget _buildBottomActionBar({
    required Data book,
    required bool hasDiscount,
    required bool inStock,
    required int maxStock,
  }) {
    final priceStr = _displayCurrentPrice(book);
    final originalPriceStr = _displayOriginalPrice(book);

    return Container(
      padding: EdgeInsets.only(
        left: 20.w,
        right: 20.w,
        top: 14.h,
        bottom: 24.h,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, -4),
          ),
        ],
        border: Border(
          top: BorderSide(color: AppColors.borderColor, width: 1),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Price Info
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Price',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayColor,
                    ),
                  ),
                  4.verticalSpace,
                  Row(
                    children: [
                      Text(
                        priceStr,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.backColor,
                        ),
                      ),
                      if (hasDiscount) ...[
                        8.horizontalSpace,
                        Text(
                          originalPriceStr,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.grayColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                        ),
                      ],
                    ],
                  ),
                ],
              ),

              // Quantity Selector
              Container(
                padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.backGroundColor,
                  borderRadius: BorderRadius.circular(12.r),
                  border: Border.all(color: AppColors.borderColor, width: 1),
                ),
                child: Row(
                  children: [
                    _buildQuantityButton(
                      icon: Icons.remove_rounded,
                      onTap: _quantity > 1
                          ? () => setState(() => _quantity--)
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        '$_quantity',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.w700,
                          color: AppColors.backColor,
                        ),
                      ),
                    ),
                    _buildQuantityButton(
                      icon: Icons.add_rounded,
                      onTap: (_quantity < maxStock && inStock)
                          ? () => setState(() => _quantity++)
                          : null,
                    ),
                  ],
                ),
              ),
            ],
          ),
          14.verticalSpace,

          // Add to Cart Main Button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: inStock
                  ? () {
                      _showSnackBar(
                        'Added $_quantity item(s) to cart!',
                        icon: Icons.check_circle_rounded,
                        isSuccess: true,
                      );
                    }
                  : null,
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    inStock ? AppColors.backColor : Colors.grey.shade400,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shopping_bag_outlined,
                    size: 20.sp,
                    color: Colors.white,
                  ),
                  10.horizontalSpace,
                  Text(
                    inStock ? 'Add To Cart' : 'Out Of Stock',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    final isEnabled = onTap != null;
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8.r),
        child: Container(
          width: 32.w,
          height: 32.h,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: isEnabled ? Colors.white : Colors.transparent,
            borderRadius: BorderRadius.circular(8.r),
            boxShadow: isEnabled
                ? [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 4,
                      offset: const Offset(0, 1),
                    ),
                  ]
                : null,
          ),
          child: Icon(
            icon,
            size: 16.sp,
            color: isEnabled ? AppColors.backColor : AppColors.grayColor,
          ),
        ),
      ),
    );
  }

  // --- Price helpers ---
  String _displayCurrentPrice(Data book) {
    if (book.priceAfterDiscount != null && book.priceAfterDiscount! > 0) {
      return '\$${book.priceAfterDiscount!.toStringAsFixed(2)}';
    }
    return _formatRawPrice(book.price);
  }

  String _displayOriginalPrice(Data book) {
    return _formatRawPrice(book.price);
  }

  String _formatRawPrice(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '\$0.00';
    final cleaned = raw.trim();
    if (cleaned.startsWith('\$')) return cleaned;
    return '\$$cleaned';
  }

  // --- Feedback SnackBar ---
  void _showSnackBar(
    String message, {
    required IconData icon,
    bool isSuccess = false,
  }) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.r),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        backgroundColor: AppColors.backColor,
        duration: const Duration(seconds: 2),
        content: Row(
          children: [
            Icon(
              icon,
              color: isSuccess ? const Color(0xff4CAF50) : AppColors.mainColor,
              size: 22.sp,
            ),
            12.horizontalSpace,
            Expanded(
              child: Text(
                message,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // --- Skeleton Loading View ---
  Widget _buildSkeletonView() {
    final dummyBook = Data(
      name: 'Sample Book Title Loading',
      category: 'General Category',
      description:
          'This is placeholder text for the book overview while the details are being fetched from the server. It gives the user an accurate outline.',
      price: '\$99.00',
      stock: 12,
      discount: 10,
      priceAfterDiscount: 89.0,
      bestSeller: 1,
    );

    return Skeletonizer(
      enabled: true,
      effect: const ShimmerEffect(
        baseColor: Color(0xffE6E8EB),
        highlightColor: Color(0xffF7F8F9),
      ),
      child: _buildDetailsContent(dummyBook),
    );
  }

  // --- Error View ---
  Widget _buildErrorView({
    required String title,
    required String message,
  }) {
    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 8.h),
            child: Row(
              children: [
                _buildCircleIconButton(
                  icon: Icons.arrow_back_ios_new_rounded,
                  onTap: () => Navigator.of(context).pop(),
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
                        onPressed: () {
                          final id = _resolvedBookId;
                          if (id != null) {
                            context.read<BookDetailsCubit>().getDetails(id);
                          }
                        },
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
