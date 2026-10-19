import 'package:bookkia/feature/auth/data/repo/auth_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  login({required String email, required String password}) async {
    emit(LoginLoadingState());
    final response = await AuthRepo.login(email: email, password: password);
    if (response) {
      emit(LoginSuccessState());
    } else {
      emit(LoginErrrState());
    }
  }
}
