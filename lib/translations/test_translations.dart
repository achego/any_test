import 'package:easy_localization/easy_localization.dart';
const translationKey = 'test';
class TestTranslation {
/// Hello bro what is your name
  String get whatYourName => '$translationKey.what_your_name'.tr();
/// were talking of dob
  String get dov => '$translationKey.dov'.tr();
}
