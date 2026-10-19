import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:bookkia/core/widget/main_button.dart';
import 'package:easy_localization/easy_localization.dart';
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
            IconButton(
              onPressed: () {
                if (context.locale.languageCode == "ar") {
                  context.setLocale(Locale("en"));
                } else {
                  context.setLocale(Locale("ar"));
                }
              },
              icon: Icon(Icons.language),
            ),
            Image.asset("assests/images/spash.png"),
            28.verticalSpace,
            Text("Order Your Book Now!", style: AppTextStyle().font30Regular.copyWith(fontSize: 20.sp)),
            Spacer(),
            AppButton(
              buttonText: 'Login',
              onTap: () {
                Navigator.pushNamed(context, AppRoute.loginScreen);
              },
            ),
            20.verticalSpace,
            AppButton(
              buttonText: 'Register',
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
