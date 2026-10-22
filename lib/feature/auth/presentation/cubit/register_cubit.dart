import 'package:bloc/bloc.dart';
import 'package:bookkia/feature/auth/data/repo/auth_repo.dart';
import 'package:meta/meta.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

  register({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirmation,
  }) async {
    emit(RegisterLoadingState());
    final response = await AuthRepo.register(
      userName: userName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
    );
    if (response) {
      RegisterSuccessState();
    } else {
      RegisterErrorState();
    };   
  }
}
