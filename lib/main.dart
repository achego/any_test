import 'package:any_test/app/components/localization_container.dart';
import 'package:any_test/core/app_initialization.dart';
import 'package:any_test/home_page.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void main(List<String> args) async {
  await AppInitialization().init();
  runApp(
    const LocalizationContainer(
      // supportedLocales: const [Locale('en', 'US')],
      // path: 'assets/translations',
      // fallbackLocale: const Locale('en', 'US'),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        ...context.localizationDelegates,
        DefaultCupertinoLocalizations.delegate,
        CustomFallBackDelegate(),
      ],
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      home: const HomePage(),
    );
  }
}

class CustomFallBackDelegate
    extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) => true;
  @override
  Future<MaterialLocalizations> load(Locale locale) async =>
      const DefaultMaterialLocalizations();
  @override
  bool shouldReload(LocalizationsDelegate<MaterialLocalizations> old) => false;
}
