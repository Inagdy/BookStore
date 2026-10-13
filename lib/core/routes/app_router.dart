import 'package:bookkia/core/routes/app_route.dart';
import 'package:bookkia/feature/auth/presentation/login_sceen.dart';
import 'package:bookkia/feature/welcome/presentation/ui/welcome_screen.dart';
import 'package:flutter/material.dart';

 class AppRouter {

  static Route? onGeneraRoute(RouteSettings setting){
    switch (setting.name){
          case AppRoute.loginScreen:
            return MaterialPageRoute(builder: (_) => LoginSceen());
          case AppRoute.registerScreen:
            return MaterialPageRoute(builder: (_) => LoginSceen());
          case AppRoute.welcome_screen:
            return MaterialPageRoute(builder: (_) => WelcomeScreen());
    }

  }
}