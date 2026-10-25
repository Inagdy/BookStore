import 'package:bookkia/feature/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());

   void register({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    emit(RegisterLoadingState());
    final response = await AuthRepo.register(
      userName: userName,
      email: email,
      password: password,
      passwordConfirmation: passwordConfirmation,
      address:address,
      city:city,
    );
    if (response) {
      emit(RegisterSuccessState());
    } else {
      emit(RegisterErrorState());
    } 
  }
}
