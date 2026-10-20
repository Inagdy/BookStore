import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:bookkia/core/widget/auth_button_text.dart';
import 'package:bookkia/core/widget/backword_button.dart';
import 'package:bookkia/feature/auth/presentation/ui/widget/login_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class LoginSceen extends StatelessWidget {
  const LoginSceen({super.key});

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
              "Welcome back! Glad \n to see you ,Again ",
              style: AppTextStyle().font30Regular,
            ),
            32.verticalSpace,
            LoginForm(),
            Spacer(),
            Center(
              child: AuthButtonText(
                leftText: 'Don’t have an account? ',
                rigthText: ' Register Now',
                onRigthTap: () {
                  Navigator.pushNamed(context, AppRoute.registerScreen);
                },
              ),
            ),
            27.verticalSpace,
          ],
        ),
      ),
    );
  }
}
