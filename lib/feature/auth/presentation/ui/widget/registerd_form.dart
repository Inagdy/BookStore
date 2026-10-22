import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/utils/app_validator.dart';
import 'package:bookkia/core/widget/auth_button_text.dart';
import 'package:bookkia/core/widget/custome_text_form_feild.dart';
import 'package:bookkia/core/widget/main_button.dart';
import 'package:bookkia/feature/auth/data/repo/auth_repo.dart';
import 'package:bookkia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookkia/feature/auth/presentation/cubit/register_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterdForm extends StatefulWidget {
  RegisterdForm({super.key});
  var userNameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var confirmPasswordController = TextEditingController();

  @override
  State<RegisterdForm> createState() => _RegisterdFormState();
}

class _RegisterdFormState extends State<RegisterdForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    widget.userNameController.dispose();
    widget.emailController.dispose();
    widget.passwordController.dispose();
    widget.confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterLoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => AlertDialog(
              backgroundColor: Colors.transparent,
              content: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (state is RegisterSuccessState) {
          Navigator.pushNamed(context, AppRoute.loginScreen);
        } else {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (context) => AlertDialog(content: Text("Error")),
          );
        }
      },
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomeTextFormFeild(
              hintText: "Username",
              controller: widget.userNameController,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "User Name is required";
                }
                if (v.length < 8) {
                  return "User Name must be more than 8 Char";
                }
                return null;
              },
            ),
            11.verticalSpace,
            CustomeTextFormFeild(
              hintText: "Email",
              controller: widget.emailController,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Email is required";
                }
                if (!AppValidator.isEmailValid(v)) {
                  return "Please return Valid Email";
                }
                return null;
              },
            ),
            11.verticalSpace,
            CustomeTextFormFeild(
              hintText: "Password",
              controller: widget.passwordController,
              isPassword: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Password is required";
                }
                if (v.length < 8) {
                  return "Password must be at least 8 characters";
                }
                if (!v.contains(RegExp(r'[A-Z]'))) {
                  return "Password must contain an uppercase letter";
                }
                if (!v.contains(RegExp(r'[a-z]'))) {
                  return "Password must contain a lowercase letter";
                }
                if (!v.contains(RegExp(r'[0-9]'))) {
                  return "Password must contain a number";
                }
                if (!v.contains(RegExp(r'[!@#$&*~]'))) {
                  return "Password must contain a special char (!@#\$&*~)";
                }
                return null;
              },
            ),
            11.verticalSpace,
            CustomeTextFormFeild(
              hintText: "Confirm password",
              controller: widget.confirmPasswordController,
              isPassword: true,
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return "Confirm Password is required";
                }
                if (v != widget.passwordController.text) {
                  return "password and confirm Password is not equal";
                }
                return null;
              },
            ),
            30.verticalSpace,
            AppButton(
              buttonText: "Register",
              bgColor: AppColors.mainColor,
              textColor: AppColors.backGroundColor,
              onTap: () {
                if(_formKey.currentState!.validate()){
                  context.read<RegisterCubit>().register(
                    userName: widget.userNameController.text,
                    email: widget.emailController.text,
                    password: widget.passwordController.text,
                    passwordConfirmation: widget.confirmPasswordController.text,
                  );
                }
              },
            ),
            148.verticalSpace,
            AuthButtonText(
              leftText: "Already have an account ? ",
              rigthText: " Login Now",
              onRigthTap: () {
                Navigator.pushNamed(context, AppRoute.loginScreen);
              },
            ),
            27.verticalSpace,
          ],
        ),
      ),
    );
  }
}
