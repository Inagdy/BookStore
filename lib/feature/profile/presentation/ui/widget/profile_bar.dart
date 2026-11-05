import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/core/services/locale/local_server.dart';
import 'package:bookkia/core/theme/app_text_style.dart';
import 'package:bookkia/core/utils/app_constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileBar extends StatelessWidget {
  const ProfileBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Text(
        'Profile',
        style: AppTextStyle().font30Regular.copyWith(fontSize: 24.sp),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            onPressed: () {
              showDialog(context: context, builder: (context)=> AlertDialog(
                title: const Text('Logout'),
                content: const Text('Are you sure you want to logout?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Cancel'),
                  ),
                  TextButton(
                    onPressed: () {
                      LocaleHlper.prefs?.remove(AppConstance.userToken); // Clear shared preferences
                      // Perform logout action here
                      Navigator.pushNamedAndRemoveUntil(context, AppRoute.loginScreen, (e) => false);
                    },
                    child: const Text('Logout'),
                  ),
                ],
              ));
            },
            icon: const Icon(Icons.logout),
          ),
        ),
      
      ],
    );
  }
}