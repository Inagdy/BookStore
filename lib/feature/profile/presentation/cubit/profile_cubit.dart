import 'package:bloc/bloc.dart';
import 'package:bookkia/feature/profile/data/model/profile_response_model.dart';
import 'package:bookkia/feature/profile/data/repo/profile_repo.dart';
import 'package:meta/meta.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());


  getProfileData() async {
    emit(GetProfileLoaded());

      final responed = await ProfileRepo.getProfileData();
      if (responed is ProfileData) {
        emit(GetProfileSuccess(responed));
      } else {
        emit(GetProfileError());
      } 

  }
}
