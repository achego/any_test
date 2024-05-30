import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class AppInitialization {
  init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await EasyLocalization.ensureInitialized();
  }
}
