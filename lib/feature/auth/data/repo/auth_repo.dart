import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/networking/dio_factore.dart';
import 'package:bookkia/core/services/locale/local_server.dart';
import 'package:bookkia/core/utils/app_constance.dart';

class AuthRepo {

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await DioFactore.dio?.post(
        ApiEndpoint.login,
        data: {"email": email, "password": password},
      );
      if (response?.statusCode == 200) {
        String? token = response?.data["data"]["token"];
        saveToken(token);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

static Future<void> saveToken(String? token) async {
  await LocaleHlper.prefs?.setString(AppConstance.userToken, token ?? "");
}

  static Future<bool> register({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    try {
      final response = await DioFactore.dio?.post(
        ApiEndpoint.register,
        data: {
          "name": userName,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
          "address": address,
          "city": city,
        },
      );
      if (response?.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
