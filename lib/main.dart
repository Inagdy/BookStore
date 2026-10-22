import 'package:bookkia/bookia_app.dart';
import 'package:bookkia/core/services/locale/local_server.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  LocaleHlper.init();
  runApp(
    EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assests/translations',
      fallbackLocale: Locale('en'),
      child: BookiaApp(),
    ),
  );
}
