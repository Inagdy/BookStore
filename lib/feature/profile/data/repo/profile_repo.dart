import 'package:bookkia/core/networking/api_endpoint.dart';
import 'package:bookkia/core/networking/dio_factore.dart';
import 'package:bookkia/feature/profile/data/model/profile_response_model.dart';

class ProfileRepo {
  static Future<ProfileData?> getProfileData() async {
    try {
      final respond = await DioFactore.dio?.get(ApiEndpoint.profile);
      if (respond?.statusCode == 200) {
        ProfileResponse profileResponse =
            ProfileResponse.fromJson(respond?.data);
        return profileResponse.data;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
