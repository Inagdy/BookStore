import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class LoginSceen extends StatelessWidget {
  const LoginSceen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushNamed(context, AppRoute.loginScreen);
            },
            icon: Icon(Icons.abc, color:AppColors.mainColor),
          ),
        ],
      ),
    );
  }
}
