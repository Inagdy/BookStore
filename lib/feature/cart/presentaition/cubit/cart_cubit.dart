import 'package:bookkia/core/networking/api_error_handling.dart';
import 'package:bookkia/feature/cart/data/model/cart_model.dart';
import 'package:bookkia/feature/cart/data/repo/cart_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartData? currentCart;

  Future<void> getCartData() async {
    emit(GetCartLoading());
    try {
      final response = await CartRepo.getCartData();
      if (response != null) {
        currentCart = response;
        emit(GetCartSuccess(response));
      } else {
        emit(GetCartError('Failed to load cart data'));
      }
    } on DioException catch (e) {
      final errorMessage = ApiErrorHandling.handlingDioException(e);
      emit(GetCartError(errorMessage));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    emit(GetCartLoading());
    try {
      final success = await CartRepo.removeFromCart(cartItemId: cartItemId);
      if (success) {
        await getCartData();
      } else {
        emit(GetCartError('Failed to remove item from cart'));
      }
    } on DioException catch (e) {
      final errorMessage = ApiErrorHandling.handlingDioException(e);
      emit(GetCartError(errorMessage));
    }
  }

  Future<void> updateCartQuantity(int cartItemId, int quantity) async {
    if (quantity <= 0) {
      await removeFromCart(cartItemId);
      return;
    }
    emit(GetCartLoading());
    final success = await CartRepo.updateCart(
      cartItemId: cartItemId,
      quantity: quantity,
    );
    if (success) {
      await getCartData();
    } else {
      emit(GetCartError('Failed to update item quantity'));
    }
  }
}
