import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/networking/dio_factore.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';

class HomeRepo {
  static Future<BookModel?>? getBestsellerBooks() async {
    try {
      final reponed = await DioFactore.dio?.get(ApiEndpoint.bestSeller);
      if (reponed?.statusCode == 200) {
        BookModel books = BookModel.fromJson(reponed?.data);
        return books;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  static Future<List<Products?>?> searchProducts(String text) async {
    try {
      final responed = await DioFactore.dio?.get(
        ApiEndpoint.search,
        queryParameters: {"name": text},
      );
      if (responed?.statusCode == 200) {
        BookModel searchBook = BookModel.fromJson(responed?.data);
        return searchBook.data?.products;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
