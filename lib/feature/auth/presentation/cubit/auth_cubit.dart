import 'package:bookkia/core/networking/api_error_handling.dart';
import 'package:bookkia/feature/auth/data/repo/auth_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  Future<void> login({required String email, required String password}) async {
    emit(LoginLoadingState());
    try {
      final response = await AuthRepo.login(email: email, password: password);
      if (response) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrrState(error: "Email or password is incorrect"));
      }
    } on DioException catch (e) {
      final errorMessage = ApiErrorHandling.handlingDioException(e);
      emit(LoginErrrState(error: errorMessage));
    } catch (e) {
      emit(LoginErrrState(error: "Something went wrong, please try again"));
    }
  }

  Future<void> register({
    required String userName,
    required String email,
    required String password,
    required String passwordConfirmation,
    required String address,
    required String city,
  }) async {
    emit(LoginLoadingState());
    try {
      final response = await AuthRepo.register(
        userName: userName,
        email: email,
        password: password,
        passwordConfirmation: passwordConfirmation,
        address: address,
        city: city,
      );
      if (response) {
        emit(LoginSuccessState());
      } else {
        emit(LoginErrrState());
      }
    } on DioException catch (e) {
      final errorMessage = ApiErrorHandling.handlingDioException(e);
      emit(LoginErrrState(error: errorMessage));
    }
  }
}
  

