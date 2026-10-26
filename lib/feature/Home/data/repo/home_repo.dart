import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/networking/dio_factore.dart';
import 'package:bookkia/feature/Home/data/model/books_model.dart';

class HomeRepo {
  static getBestsellerBooks() async {
    try {
      final reponed = await DioFactore.dio?.get(
        ApiEndpoint.bestSeller,
      );
      if (reponed?.statusCode==200) {
        BookModel books = BookModel.fromJson(reponed?.data);
        return books;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
