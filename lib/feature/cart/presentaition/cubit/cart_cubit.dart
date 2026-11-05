import 'package:bookkia/feature/cart/data/model/cart_model.dart';
import 'package:bookkia/feature/cart/data/repo/cart_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  CartData? currentCart;

  Future<void> getCartData() async {
    emit(GetCartLoading());
    final response = await CartRepo.getCartData();
    if (response != null) {
      currentCart = response;
      emit(GetCartSuccess(response));
    } else {
      emit(GetCartError('Failed to load cart data'));
    }
  }

  Future<void> removeFromCart(int cartItemId) async {
    emit(GetCartLoading());
    final success = await CartRepo.removeFromCart(cartItemId: cartItemId);
    if (success) {
      await getCartData();
    } else {
      emit(GetCartError('Failed to remove item from cart'));
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
