import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/feature/Home/cubit/home_cubit.dart';
import 'package:bookkia/feature/Home/presentation/ui/home_screen.dart';
import 'package:bookkia/feature/Home/presentation/ui/search_screen.dart';
import 'package:bookkia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookkia/feature/auth/presentation/cubit/register_cubit.dart';
import 'package:bookkia/feature/auth/presentation/login_sceen.dart';
import 'package:bookkia/feature/auth/presentation/registerd_screen.dart';
import 'package:bookkia/feature/book_details/presentation/cubit/book_details_cubit.dart';
import 'package:bookkia/feature/book_details/presentation/ui/booK_Details_screen.dart';
import 'package:bookkia/feature/welcome/presentation/ui/welcome_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  static Route? onGeneraRoute(RouteSettings setting) {
    switch (setting.name) {
      case AppRoute.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => AuthCubit(),
            child: LoginSceen(),
          ),
        );
      case AppRoute.homeScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..getBestsellerBooks(),
            child: HomeScreen(),
          ),
        );
      case AppRoute.welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case AppRoute.registerScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => RegisterCubit(),
            child: RegisterdScreen(),
          ),
        );
      case AppRoute.searchScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeCubit()..searchBookNames(" "),
            child: SearchScreen(),
          ),
        );
      case AppRoute.bookDetails:
        int id = setting.arguments as int;
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => BookDetailsCubit()..getDetails(id),
            child: BookDetailsScreen(),
          ),
        );
      default:
        return null;
    }
  }
}
