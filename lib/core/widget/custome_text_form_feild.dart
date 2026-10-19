import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomeTextFormFeild extends StatefulWidget {
  final String? hintText;
  final bool isPassword;
  final String? Function(String?)? validator;
  final TextEditingController controller;
  const CustomeTextFormFeild({super.key, this.hintText,this.isPassword=false, this.validator, required this.controller});

  @override
  State<CustomeTextFormFeild> createState() => _CustomeTextFormFeildState();
}

class _CustomeTextFormFeildState extends State<CustomeTextFormFeild> {
  bool isobscure = true;

  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator:widget.validator,
      obscureText: widget.isPassword && isobscure,
      onTapOutside: (v) {
        FocusScope.of(context).unfocus();
      },
      cursorColor: AppColors.mainColor,
      decoration: InputDecoration(
        suffixIcon: widget.isPassword?InkWell(
          onTap: () {
            setState(() {
              
            isobscure =! isobscure;
            });

          },
          child: Icon(Icons.visibility)):null,
        fillColor: Colors.white,
        filled: true,
        hintStyle: AppTextStyle().hitTextStyle,
        hintText: widget.hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(color: AppColors.borderColor),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0.r),
          borderSide: BorderSide(color: AppColors.mainColor),
        ),
      ),
    );
  }
}
