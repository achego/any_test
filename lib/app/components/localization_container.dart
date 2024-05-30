import 'package:any_test/core/data.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class LocalizationContainer extends StatelessWidget {
  const LocalizationContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return EasyLocalization(
      supportedLocales: supportedAppLocale.map((e) => e.locale).toList(),
      path: _translationPath,
      fallbackLocale: const Locale('en', 'US'),
      // errorWidget: (message) => Container(
      //   height: 200,
      //   width: 200,
      //   color: Colors.red,
      //   child: Text(message?.message ?? ""),
      // ),
      child: child,
    );
  }
}

const _translationPath = 'assets/translations';
