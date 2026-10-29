import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_details_content.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_details_error_view.dart';
import 'package:bookkia/feature/book_details/presentation/ui/widget/book_details_skeleton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDetailsScreen extends StatefulWidget {
  final int? bookId;

  const BookDetailsScreen({super.key, this.bookId});

  @override
  State<BookDetailsScreen> createState() => _BookDetailsScreenState();
}

class _BookDetailsScreenState extends State<BookDetailsScreen> {
  bool _isBookmarked = false;

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
            return const BookDetailsSkeleton();
          } else if (state is GetbookDetailsSucces) {
            final book = state.details.data;
            if (book == null) {
              return BookDetailsErrorView(
                title: 'Book Not Found',
                message: 'Could not load details for this book.',
                onRetry: _retryLoading,
              );
            }
            return BookDetailsContent(
              book: book,
              isBookmarked: _isBookmarked,
              onBookmarkTap: () => _toggleBookmark(book.name),
              onAddToCart: (quantity) => _handleAddToCart(book.name, quantity),
            );
          } else {
            return BookDetailsErrorView(
              title: 'Something went wrong',
              message:
                  'Failed to load book details. Please check your connection.',
              onRetry: _retryLoading,
            );
          }
        },
      ),
    );
  }

  void _retryLoading() {
    final id = _resolvedBookId;
    if (id != null) {
      context.read<BookDetailsCubit>().getDetails(id);
    }
  }

  void _toggleBookmark(String? bookTitle) {
    setState(() {
      _isBookmarked = !_isBookmarked;
    });
    _showFeedbackSnackBar(
      _isBookmarked
          ? 'Saved "${bookTitle ?? 'Book'}" to your wishlist!'
          : 'Removed from wishlist',
      icon: _isBookmarked
          ? Icons.bookmark_added_rounded
          : Icons.bookmark_remove_rounded,
    );
  }

  void _handleAddToCart(String? bookTitle, int quantity) {
    _showFeedbackSnackBar(
      'Added $quantity item(s) to cart!',
      icon: Icons.check_circle_rounded,
      isSuccess: true,
    );
  }

  void _showFeedbackSnackBar(
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
}
