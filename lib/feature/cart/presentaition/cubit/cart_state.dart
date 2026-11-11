part of 'cart_cubit.dart';

@immutable
sealed class CartState {}

final class CartInitial extends CartState {}

final class GetCartLoading extends CartState {}

final class GetCartSuccess extends CartState {
  final CartData cartData;
  GetCartSuccess(this.cartData);
}

final class GetCartError extends CartState {
  final String message;
  GetCartError(this.message);
}
