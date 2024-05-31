import 'package:easy_localization/easy_localization.dart';
const translationKey = 'gender';
class GenderTranslation {
/// Hi man ;) {}
  String male(String p0 ) => 'male'.tr(args: [p0] ,  );
/// Hello girl :) {}
  String female(String p0 ) => 'female'.tr(args: [p0] ,  );
/// Hello {}
  String other(String p0 ) => 'other'.tr(args: [p0] ,  );
}
