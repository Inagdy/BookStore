import 'package:bookkia/core/theme/app_colors.dart';
import 'package:bookkia/feature/Home/cubit/home_cubit.dart';
import 'package:bookkia/feature/Home/presentation/ui/home_screen.dart';
import 'package:bookkia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookkia/feature/profile/presentation/profile_screen.dart';
import 'package:bookkia/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

class BottomNavBarScreen extends StatefulWidget {
  BottomNavBarScreen({super.key});

  @override
  State<BottomNavBarScreen> createState() => _BottomNavBarScreenState();
}

class _BottomNavBarScreenState extends State<BottomNavBarScreen> {
  int currentIndex = 0;
  List<Widget> screens = [
    BlocProvider(
      create: (context) => HomeCubit()..getBestsellerBooks(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => HomeCubit()..getBestsellerBooks(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => HomeCubit()..getBestsellerBooks(),
      child: HomeScreen(),
    ),
    BlocProvider(
      create: (context) => HomeCubit()..getBestsellerBooks(),
      child: BlocProvider(
        create: (context) => ProfileCubit()..getProfileData(),
        child: ProfileScreen(),
      ),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        backgroundColor: AppColors.backGroundColor,
        selectedItemColor: AppColors.mainColor,
        unselectedItemColor: AppColors.backColor,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.assests.icons.home,
              colorFilter: ColorFilter.mode(
                currentIndex == 0 ? AppColors.mainColor : AppColors.backColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.assests.icons.bookmark,
              colorFilter: ColorFilter.mode(
                currentIndex == 1 ? AppColors.mainColor : AppColors.backColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.assests.icons.category,
              colorFilter: ColorFilter.mode(
                currentIndex == 2 ? AppColors.mainColor : AppColors.backColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              Assets.assests.icons.profile,
              colorFilter: ColorFilter.mode(
                currentIndex == 3 ? AppColors.mainColor : AppColors.backColor,
                BlendMode.srcIn,
              ),
            ),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
