import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BookBottomActionBar extends StatefulWidget {
  final String? price;
  final double? priceAfterDiscount;
  final int? discount;
  final int? stock;
  final void Function(int quantity)? onAddToCart;

  const BookBottomActionBar({
    super.key,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.stock,
    this.onAddToCart,
  });

  @override
  State<BookBottomActionBar> createState() => _BookBottomActionBarState();
}

class _BookBottomActionBarState extends State<BookBottomActionBar> {
  int _quantity = 1;

  @override
  Widget build(BuildContext context) {
    final hasDiscount = (widget.discount != null && widget.discount! > 0);
    final inStock = (widget.stock == null || widget.stock! > 0);
    final maxStock = widget.stock ?? 99;

    final currentPrice = _formatCurrentPrice();
    final originalPrice = _formatOriginalPrice();

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
                        currentPrice,
                        style: TextStyle(
                          fontSize: 22.sp,
                          fontWeight: FontWeight.w800,
                          color: AppColors.backColor,
                        ),
                      ),
                      if (hasDiscount) ...[
                        8.horizontalSpace,
                        Text(
                          originalPrice,
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

              // Quantity Stepper
              QuantityStepper(
                quantity: _quantity,
                maxStock: maxStock,
                inStock: inStock,
                onDecrement: _quantity > 1
                    ? () => setState(() => _quantity--)
                    : null,
                onIncrement: (_quantity < maxStock && inStock)
                    ? () => setState(() => _quantity++)
                    : null,
              ),
            ],
          ),
          14.verticalSpace,

          // Add to Cart Button
          SizedBox(
            width: double.infinity,
            height: 52.h,
            child: ElevatedButton(
              onPressed: inStock
                  ? () => widget.onAddToCart?.call(_quantity)
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

  String _formatCurrentPrice() {
    if (widget.priceAfterDiscount != null && widget.priceAfterDiscount! > 0) {
      return '\$${widget.priceAfterDiscount!.toStringAsFixed(2)}';
    }
    return _formatRawPrice(widget.price);
  }

  String _formatOriginalPrice() {
    return _formatRawPrice(widget.price);
  }

  String _formatRawPrice(String? raw) {
    if (raw == null || raw.trim().isEmpty) return '\$0.00';
    final cleaned = raw.trim();
    if (cleaned.startsWith('\$')) return cleaned;
    return '\$$cleaned';
  }
}

class QuantityStepper extends StatelessWidget {
  final int quantity;
  final int maxStock;
  final bool inStock;
  final VoidCallback? onIncrement;
  final VoidCallback? onDecrement;

  const QuantityStepper({
    super.key,
    required this.quantity,
    required this.maxStock,
    required this.inStock,
    required this.onIncrement,
    required this.onDecrement,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 4.h),
      decoration: BoxDecoration(
        color: AppColors.backGroundColor,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.borderColor, width: 1),
      ),
      child: Row(
        children: [
          QuantityButton(
            icon: Icons.remove_rounded,
            onTap: onDecrement,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: Text(
              '$quantity',
              style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w700,
                color: AppColors.backColor,
              ),
            ),
          ),
          QuantityButton(
            icon: Icons.add_rounded,
            onTap: onIncrement,
          ),
        ],
      ),
    );
  }
}

class QuantityButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback? onTap;

  const QuantityButton({
    super.key,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
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
}

