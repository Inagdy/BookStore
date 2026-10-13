import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:bookkia/core/widget/main_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        width: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: Image.asset('assests/images/welcome_background.png').image,
          ),
        ),
        child: Column(
          children: [
            135.verticalSpace,
            Image.asset("assests/images/spash.png"),
            28.verticalSpace,
            Text("Order Your Book Now!", style: AppTextStyle().hitTextStyle),
            Spacer(),
            AppButton(button_Text: 'Login' ,onTap: () {
              Navigator.pushNamed(context, AppRoute.loginScreen);
            },),
            20.verticalSpace,
            AppButton(
              button_Text: 'Register',
              bgColor: Colors.white,
              textColor: Colors.black,
            ),
            94.verticalSpace,
          ],
        ),
      ),
    );
  }
}
