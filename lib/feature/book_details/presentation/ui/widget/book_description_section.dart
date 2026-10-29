import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookDescriptionSection extends StatefulWidget {
  final String? description;

  const BookDescriptionSection({super.key, this.description});

  @override
  State<BookDescriptionSection> createState() => _BookDescriptionSectionState();
}

class _BookDescriptionSectionState extends State<BookDescriptionSection> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final text = (widget.description != null && widget.description!.trim().isNotEmpty)
        ? widget.description!.trim()
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
            crossFadeState: _isExpanded || !isLongText
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
                  _isExpanded = !_isExpanded;
                });
              },
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    _isExpanded ? 'Read Less' : 'Read More',
                    style: TextStyle(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w700,
                      color: AppColors.mainColor,
                    ),
                  ),
                  4.horizontalSpace,
                  Icon(
                    _isExpanded
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
}

