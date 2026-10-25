import 'package:bookkia/feature/Home/data/model/books_model.dart';
import 'package:dio/dio.dart';

class HomeRepo {
  static Dio dio = Dio();
  static getBestsellerBooks() async {
    try {
      final reponed = await dio.get(
        "https://codingarabic.eraapro.com/api/products-bestseller",
      );
      if (reponed.statusCode==200) {
        BookModel books = BookModel.fromJson(reponed.data);
        return books;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
