import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:bookkia/feature/cart/presentaition/cubit/cart_cubit.dart';
import 'package:bookkia/feature/cart/presentaition/ui/widget/cart_item_card.dart';
import 'package:bookkia/feature/cart/presentaition/ui/widget/cart_total_bottom_bar.dart';
import 'package:bookkia/feature/cart/presentaition/ui/widget/empty_cart_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Cart',
          style: AppTextStyle().font30Regular.copyWith(
                fontSize: 24.sp,
                color: AppColors.backColor,
              ),
        ),
      ),
      body: BlocConsumer<CartCubit, CartState>(
        listener: (context, state) {
          if (state is GetCartError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: Colors.red,
                duration: const Duration(seconds: 2),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is GetCartLoading &&
              context.read<CartCubit>().currentCart == null) {
            return const Center(
              child: CircularProgressIndicator(
                color: AppColors.mainColor,
              ),
            );
          }

          final cartData = (state is GetCartSuccess)
              ? state.cartData
              : context.read<CartCubit>().currentCart;

          if (cartData != null) {
            if (cartData.cartItems.isEmpty) {
              return EmptyCartView(
                onRefresh: () => context.read<CartCubit>().getCartData(),
              );
            }

            return Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: RefreshIndicator(
                        color: AppColors.mainColor,
                        onRefresh: () =>
                            context.read<CartCubit>().getCartData(),
                        child: ListView.separated(
                          padding: EdgeInsets.only(
                            left: 16.w,
                            right: 16.w,
                            top: 10.h,
                            bottom: 120.h,
                          ),
                          itemCount: cartData.cartItems.length,
                          separatorBuilder: (context, index) =>
                              14.h.verticalSpace,
                          itemBuilder: (context, index) {
                            final item = cartData.cartItems[index];
                            return CartItemCard(
                              item: item,
                              onRemove: () =>
                                  _showDeleteDialog(context, item.itemId),
                              onQuantityChanged: (newQty) {
                                context
                                    .read<CartCubit>()
                                    .updateCartQuantity(item.itemId, newQty);
                              },
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: CartTotalBottomBar(
                    total: cartData.total,
                    onCheckout: () => _handleCheckout(context),
                  ),
                ),
              ],
            );
          }

          if (state is GetCartError) {
            return Center(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline_rounded,
                      size: 60.r,
                      color: Colors.red.shade400,
                    ),
                    16.h.verticalSpace,
                    Text(
                      state.message,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: AppColors.backColor,
                      ),
                    ),
                    20.h.verticalSpace,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.mainColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                      ),
                      onPressed: () => context.read<CartCubit>().getCartData(),
                      child: const Text(
                        'Retry',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  void _showDeleteDialog(BuildContext context, int cartItemId) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.r),
        ),
        title: const Text('Remove from cart'),
        content: const Text(
          'Are you sure you want to remove this book from your cart?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext);
              context.read<CartCubit>().removeFromCart(cartItemId);
            },
            child: const Text(
              'Remove',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }

  void _handleCheckout(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Proceeding to checkout...'),
        backgroundColor: AppColors.mainColor,
        duration: Duration(seconds: 2),
      ),
    );
  }
}
