import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/utils/app_validator.dart';
import 'package:bookkia/core/widget/auth_button_text.dart';
import 'package:bookkia/core/widget/custome_text_form_feild.dart';
import 'package:bookkia/core/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterdForm extends StatefulWidget {
  RegisterdForm({super.key});
  var userName = TextEditingController();
  var email = TextEditingController();
  var password = TextEditingController();
  var confirmPassword = TextEditingController();

  @override
  State<RegisterdForm> createState() => _RegisterdFormState();
}

class _RegisterdFormState extends State<RegisterdForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          CustomeTextFormFeild(
            hintText: "Username",
            controller: widget.userName,
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
            controller: widget.email,
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
            controller: widget.password,
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
            controller: widget.confirmPassword,
            isPassword: true,
            validator: (v) {
              if (v == null || v.isEmpty) {
                return "Confirm Password is required";
              }
              if (v != widget.password.text) {
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
              _formKey.currentState!.validate();
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
    );
  }
}
