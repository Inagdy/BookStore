import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/utils/app_validator.dart';
import 'package:bookkia/core/widget/custome_text_form_feild.dart';
import 'package:bookkia/core/widget/main_button.dart';
import 'package:bookkia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  var formState = GlobalKey<FormState>();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              content: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is LoginSuccessState) {
          Navigator.pushNamed(context, AppRoute.homeScreen);
        } else {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("Error")),
          );
        }
      },
      child: Form(
        key: formState,
        child: Column(
          children: [
            CustomeTextFormFeild(
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Email is required";
                }
                if (!AppValidator.isEmailValid(v ?? "")) {
                  return "Please return Valid Email";
                }
              },
              hintText: "Enter your email",
              controller: emailController,
            ),
            15.verticalSpace,
            CustomeTextFormFeild(
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Password is required";
                } else if (v.length <= 6) {
                  return "Password must be more than 6 char";
                }
              },
              hintText: "Enter your password",
              isPassword: true,
              controller: passwordController,
            ),
            30.verticalSpace,
            AppButton(
              onTap: () {
                if (formState.currentState?.validate() ?? false) {
                  context.read<AuthCubit>().login(
                    email: emailController.text,
                    password: passwordController.text,
                  );
                }
              },
              buttonText: 'Login',
            ),
          ],
        ),
      ),
    );
  }
}
