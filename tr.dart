import 'dart:convert';
import 'dart:io';

void loggerR(dynamic text, [dynamic title, int maxChars = 3000]) {
  String trace = StackTrace.current.toString().split('\n')[1];
  if (trace.contains('>')) {
    if (trace.split('>').length >= 2) {
      trace = trace.split('>')[1];
    }
  }
  final now = DateTime.now();
  final time = '${now.hour}:${now.minute}:${now.second}';

  if (title != null) {
    print(
      'rqas: \x1B[35m$time\x1B[0m - \x1B[31m${title.toString().toUpperCase()}\x1B[0m === \x1b[33m${text.toString().length > maxChars ? text.toString().substring(0, maxChars) : text.toString()}\x1B[0m \x1b[2m$trace\x1B[0m',
    );
    if ((text.toString().length + title.toString().length) >= 500) {
      print('rqas: \x1b[31m$trace\x1B[0m');
    }
  } else {
    print(
      'rqas: \x1B[35m$time\x1B[0m - \x1b[33m${text.toString().length > maxChars ? text.toString().substring(0, maxChars) : text.toString()}\x1B[0m \x1b[2m$trace\x1B[0m',
    );
    if ((text.toString().length + title.toString().length) >= 500) {
      print('rqas: \x1b[31m$trace\x1B[0m');
    }
  }
}

const packageName = 'any_test';

void main() async {
  try {
    // Specify the path to the JSON file
    const jsonFilePath = 'assets/translations/en-US.json';

    // Read the JSON file
    final jsonFile = File(jsonFilePath);
    if (!await jsonFile.exists()) {
      loggerR("JSON file not found at path: $jsonFilePath", 'Not found');
      throw Exception("JSON file not found at path: $jsonFilePath");
    }

    final jsonString = jsonFile.readAsStringSync();
    if (jsonString.isEmpty) {
      loggerR('The file is empty');
      return;
    }

    final Map<String, dynamic> jsonMap = jsonDecode(jsonString);

    // Generate the Dart code for the main translations
    final appTranslationsCode = generateAppTranslationsCode(jsonMap);
    final nestedTranslationsCode = generateNestedTranslationsCode(jsonMap);

    // Ensure the directory exists
    await Directory('lib/translations').create(recursive: true);

    // Write the main translations to app_translations.dart
    const appTranslationsFilePath = 'lib/translations/app_translations.dart';
    final appTranslationsFile = File(appTranslationsFilePath);
    appTranslationsFile.writeAsStringSync(appTranslationsCode);

    // Write the nested translations to their respective files
    for (final entry in nestedTranslationsCode.entries) {
      final filePath = 'lib/translations/${entry.key}.dart';
      final file = File(filePath);
      await file.writeAsString(entry.value);
    }

    loggerR('Translations classes have been generated successfully!');
  } catch (e) {
    loggerR(e, 'the error');
    // print('Error: $e');
  }
}

String generateAppTranslationsCode(Map<String, dynamic> jsonMap) {
  final buffer = StringBuffer();

  final importBufffers = StringBuffer();

  importBufffers
      .writeln("import 'package:easy_localization/easy_localization.dart';");
  buffer.writeln('class AppTranslations {');
  jsonMap.forEach((key, value) {
    if (value is String) {
      buffer.writeln('/// $value');
      if (value.contains('{')) {
        final placeholderRegex = RegExp(r'\{(.*?)\}');
        final matches = placeholderRegex.allMatches(value);

        final args =
            matches.where((element) => element.group(1)!.isEmpty).toList();
        final namedArgs =
            matches.where((element) => element.group(1)!.isNotEmpty).toList();

        buffer.writeln(
            "  String ${key.toCamelCase}(${args.isEmpty ? '' : args.map((e) => 'String p${args.indexOf(e)}').join(', ')} ${namedArgs.isEmpty ? '' : '${args.isNotEmpty ? ',' : ''} { ${namedArgs.map((e) => 'required String ${e.group(1)!.toCamelCase}').join(', ')}}'}) => '$key'.tr(${args.isEmpty ? '' : 'args: [${args.map((e) => 'p${args.indexOf(e)}').join(', ')}]'} ${args.isEmpty ? '' : ', '} ${namedArgs.isEmpty ? '' : 'namedArgs: {${namedArgs.map((e) => "'${e.group(1)}': ${e.group(1)!.toCamelCase}").join(', ')}}'});");
      } else {
        buffer.writeln("  String get ${key.toCamelCase} => '$key'.tr();");
      }
    } else if (value is Map<String, dynamic>) {
      importBufffers.writeln(
          "import 'package:$packageName/translations/${key}_translations.dart';");
      final className = '${key.toCamelCase.capitalizeFirst}Translation';
      buffer.writeln('/// Transations for $key');
      buffer.writeln('  final ${key.toCamelCase} = $className();');
    }
  });
  buffer.writeln('}');

  return importBufffers.toString() + buffer.toString();
}

Map<String, String> generateNestedTranslationsCode(Map<String, dynamic> jsonMap,
    {bool isNested = false, String? parent}) {
  final nestedCode = <String, String>{};

  jsonMap.forEach((key, value) {
    if (value is Map<String, dynamic>) {
      final className = '${_capitalize(key)}Translation';
      final buffer = StringBuffer();
      final importBufffers = StringBuffer();
      final nextedBuffers = StringBuffer();
      if (!isNested) {
        importBufffers.writeln(
            "import 'package:easy_localization/easy_localization.dart';");
      }
      buffer.writeln(
          "const translationKey${isNested ? key.capitalizeFirst : ''} = '${parent ?? key}';");
      buffer.writeln('class $className {');
      value.forEach((nestedKey, nestedValue) {
        if (nestedValue is String) {
          buffer.writeln('/// $nestedValue');

          if (nestedValue.contains('{')) {
            final placeholderRegex = RegExp(r'\{(.*?)\}');
            final matches = placeholderRegex.allMatches(nestedValue);

            final args =
                matches.where((element) => element.group(1)!.isEmpty).toList();
            final namedArgs = matches
                .where((element) => element.group(1)!.isNotEmpty)
                .toList();

            buffer.writeln(
                "  String ${nestedKey.toCamelCase}(${args.isEmpty ? '' : args.map((e) => 'String p${args.indexOf(e)}').join(', ')} ${namedArgs.isEmpty ? '' : '${args.isNotEmpty ? ',' : ''} { ${namedArgs.map((e) => 'required String ${e.group(1)!.toCamelCase}').join(', ')}}'}) => '$nestedKey'.tr(${args.isEmpty ? '' : 'args: [${args.map((e) => 'p${args.indexOf(e)}').join(', ')}]'} ${args.isEmpty ? '' : ', '} ${namedArgs.isEmpty ? '' : 'namedArgs: {${namedArgs.map((e) => "'${e.group(1)}': ${e.group(1)!.toCamelCase}").join(', ')}}'});");
          } else {
            buffer.writeln(
                "  String get ${_camelCase(nestedKey)} => '\$translationKey${isNested ? key.capitalizeFirst : ''}.$nestedKey'.tr();");
          }
        } else if (nestedValue is Map<String, dynamic>) {
          final className =
              '${nestedKey.toCamelCase.capitalizeFirst}Translation';
          buffer.writeln('/// Transations for $nestedKey');
          buffer.writeln('  final ${nestedKey.toCamelCase} = $className();');
          loggerR('${parent ?? key}.$nestedKey', 'The parents');
          loggerR('$parent', 'The parents 555');
          final buffers = generateNestedTranslationsCode(value,
              isNested: true, parent: '${parent ?? key}.$nestedKey');
          buffers.forEach((key, value) {
            nextedBuffers.writeln(value);
          });
        }
      });
      buffer.writeln('}');

      nestedCode['${key}_translations'] = importBufffers.toString() +
          buffer.toString() +
          nextedBuffers.toString();
    }
  });

  return nestedCode;
}

String _capitalize(String s) => s[0].toUpperCase() + s.substring(1);
String _camelCase(String s) {
  final parts = s.split('_');
  return parts[0] + parts.skip(1).map(_capitalize).join();
}

extension _StringX on String {
  String get toCamelCase {
    String finalText = '';
    final items = split('_');
    for (var element in items) {
      if (items.indexOf(element) == 0) {
        finalText += element;
      } else {
        finalText += element.capitalizeFirst;
      }
    }
    return finalText;
  }

  String get capitalizeFirst {
    return split('')[0].toUpperCase() + replaceFirst(split('')[0], '');
  }
}
