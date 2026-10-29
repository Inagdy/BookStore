import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/networking/dio_factore.dart';
import 'package:bookkia/feature/book_details/data/model/book_detials_model.dart';

class BookDetialsRepo {
  static getBookDetials(int id) async {
    try {
      final respond = await DioFactore.dio?.get(
        "${ApiEndpoint.bookDetails}/$id",
      );
      if (respond?.statusCode == 200) {
        BookDetialsModel details = BookDetialsModel.fromJson(respond?.data);
        print(details);
        return details;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
