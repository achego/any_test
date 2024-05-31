import 'package:easy_localization/easy_localization.dart';
const translationKey = 'example';
class ExampleTranslation {
/// Transations for hello
  final hello = HelloTranslation();
/// pridn ndn
  String get price => '$translationKey.price'.tr();
/// World!
  String get world => '$translationKey.world'.tr();
/// so im {} trying to {mail} test this thing o
  String helloWorld(String p0 , { required String mail}) => 'helloWorld'.tr(args: [p0] ,  namedArgs: {'mail': mail});
}
const translationKeyHello = 'example.hello';
class HelloTranslation {
/// the mean is nice
  String get meal => '$translationKeyHello.meal'.tr();
/// Transations for nice
  final nice = NiceTranslation();
}
const translationKeyNice = 'example.hello.nice';
class NiceTranslation {
/// Im over doing 
  String get test => '$translationKeyNice.test'.tr();
}


