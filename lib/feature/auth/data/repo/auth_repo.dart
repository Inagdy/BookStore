import 'package:bookkia/core/services/locale/local_server.dart';
import 'package:bookkia/core/utils/app_constance.dart';
import 'package:dio/dio.dart';

class AuthRepo {
  static Dio dio = Dio();

  static Future<bool> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await dio.post(
        "https://codingarabic.eraapro.com/api/login",
        data: {"email": email, "password": password},
      );
      if (response.statusCode == 200) {
        String? token = response.data["data"]["token"];
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
  }) async {
    try {
      final response = await dio.post(
        "https://codingarabic.eraapro.com/api/register",
        data: {
          "name": userName,
          "email": email,
          "password": password,
          "password_confirmation": passwordConfirmation,
        },
      );
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
