import 'package:any_test/app/data/models/app_locale.dart';
import 'package:flutter/material.dart';

List<AppLocaleModel> get supportedAppLocale => [
      AppLocaleModel(name: 'English', locale: const Locale('en', 'US')),
      AppLocaleModel(name: 'Igbo', locale: const Locale('ig')),
      AppLocaleModel(name: 'Krikeni', locale: const Locale('ok')),
    ];
