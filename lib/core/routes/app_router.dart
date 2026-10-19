import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/feature/Home/presentation/ui/home_screen.dart';
import 'package:bookkia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookkia/feature/auth/presentation/login_sceen.dart';
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
      case AppRoute.registerScreen:
        return MaterialPageRoute(builder: (_) => LoginSceen());
      case AppRoute.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      case AppRoute.welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      default:
        return null;
    }
  }
}
