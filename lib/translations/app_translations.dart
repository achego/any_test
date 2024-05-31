import 'package:easy_localization/easy_localization.dart';
import 'package:any_test/translations/gender_translations.dart';
import 'package:any_test/translations/example_translations.dart';
import 'package:any_test/translations/test_translations.dart';
class AppTranslations {
/// {} are written in the {} language
  String msg(String p0, String p1 ) => 'msg'.tr(args: [p0, p1] ,  );
/// Easy localization is written in the {lang} language
  String msgNamed(  { required String lang}) => 'msg_named'.tr(  namedArgs: {'lang': lang});
/// {} are written in the {lang}  and {email} language with a touch on {} and breast milk
  String msgMixed(String p0, String p1 , { required String lang, required String email}) => 'msg_mixed'.tr(args: [p0, p1] ,  namedArgs: {'lang': lang, 'email': email});
/// hey there no args
  String get heyNoArgs => 'hey_no_args'.tr();
/// Transations for gender
  final gender = GenderTranslation();
/// Transations for example
  final example = ExampleTranslation();
/// Transations for test
  final test = TestTranslation();
}
