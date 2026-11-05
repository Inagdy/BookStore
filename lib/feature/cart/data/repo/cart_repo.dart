import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/networking/dio_factore.dart';
import 'package:bookkia/feature/cart/data/model/cart_model.dart';

class CartRepo {
  static Future<CartData?> getCartData() async {
    try {
      final response = await DioFactore.dio?.get(ApiEndpoint.cart);
      if (response?.statusCode == 200) {
        CartResponse cartResponse = CartResponse.fromJson(response?.data);
        return cartResponse.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<bool> removeFromCart({required int cartItemId}) async {
    try {
      final response = await DioFactore.dio?.post(
        ApiEndpoint.removeFromCart,
        data: {'cart_item_id': cartItemId},
      );
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }

  static Future<bool> updateCart({
    required int cartItemId,
    required int quantity,
  }) async {
    try {
      final response = await DioFactore.dio?.post(
        ApiEndpoint.updateCart,
        data: {
          'cart_item_id': cartItemId,
          'quantity': quantity,
        },
      );
      if (response?.statusCode == 200 || response?.statusCode == 201) {
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
}
