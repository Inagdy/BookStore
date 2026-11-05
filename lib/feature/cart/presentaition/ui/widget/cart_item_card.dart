import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/cart/data/model/cart_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartItemCard extends StatelessWidget {
  final CartItem item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQuantityChanged;

  const CartItemCard({
    super.key,
    required this.item,
    required this.onRemove,
    required this.onQuantityChanged,
  });

  @override
  Widget build(BuildContext context) {
    final imageUrl = item.image;
    final hasImage = imageUrl.isNotEmpty;
    final displayPrice = item.priceAfterDiscount > 0
        ? item.priceAfterDiscount
        : item.price;

    return Container(
      padding: EdgeInsets.all(12.r),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.02),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Book Thumbnail
          GestureDetector(
            onTap: () {
              if (item.productId != 0) {
                Navigator.pushNamed(
                  context,
                  AppRoute.bookDetails,
                  arguments: item.productId,
                );
              }
            },
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8.r),
              child: hasImage
                  ? Image.network(
                      imageUrl,
                      width: 80.w,
                      height: 105.h,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          _placeholderImage(),
                    )
                  : _placeholderImage(),
            ),
          ),
          14.w.horizontalSpace,

          // Details Column
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          if (item.productId != 0) {
                            Navigator.pushNamed(
                              context,
                              AppRoute.bookDetails,
                              arguments: item.productId,
                            );
                          }
                        },
                        child: Text(
                          item.name,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w600,
                            color: AppColors.backColor,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: onRemove,
                      borderRadius: BorderRadius.circular(20.r),
                      child: Padding(
                        padding: EdgeInsets.all(4.r),
                        child: Icon(
                          Icons.delete_outline_rounded,
                          size: 22.r,
                          color: Colors.red.shade400,
                        ),
                      ),
                    ),
                  ],
                ),
                8.h.verticalSpace,

                // Price
                Text(
                  "\$${displayPrice.toStringAsFixed(2)}",
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.mainColor,
                  ),
                ),
                12.h.verticalSpace,

                // Quantity controls
                Row(
                  children: [
                    _quantityButton(
                      icon: Icons.remove,
                      onTap: () {
                        if (item.quantity > 1) {
                          onQuantityChanged(item.quantity - 1);
                        } else {
                          onRemove();
                        }
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 14.w),
                      child: Text(
                        '${item.quantity}',
                        style: TextStyle(
                          fontSize: 15.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.backColor,
                        ),
                      ),
                    ),
                    _quantityButton(
                      icon: Icons.add,
                      onTap: () {
                        onQuantityChanged(item.quantity + 1);
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _quantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(6.r),
      child: Container(
        padding: EdgeInsets.all(6.r),
        decoration: BoxDecoration(
          color: AppColors.backGroundColor,
          borderRadius: BorderRadius.circular(6.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Icon(
          icon,
          size: 16.r,
          color: AppColors.backColor,
        ),
      ),
    );
  }

  Widget _placeholderImage() {
    return Container(
      width: 80.w,
      height: 105.h,
      color: Colors.grey.shade200,
      child: Icon(Icons.book, size: 36.r, color: Colors.grey.shade400),
    );
  }
}
