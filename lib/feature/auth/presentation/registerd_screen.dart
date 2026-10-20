import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:bookkia/core/widget/backword_button.dart';
import 'package:bookkia/feature/auth/presentation/ui/widget/registerd_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RegisterdScreen extends StatefulWidget {
  const RegisterdScreen({super.key});

  @override
  State<RegisterdScreen> createState() => _RegisterdScreenState();
}

class _RegisterdScreenState extends State<RegisterdScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backGroundColor,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            11.verticalSpace,
            BackwordButton(),
            29.verticalSpace,
            Text(
              "Hello! Register to get \n started",
              style: AppTextStyle().font30Regular,
            ),
            32.verticalSpace,
            RegisterdForm(),
          ],
        ),
      ),
    );
  } 
}
