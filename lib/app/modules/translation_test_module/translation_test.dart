import 'package:any_test/core/data.dart';
import 'package:any_test/core/globals.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class TranslationExample extends StatelessWidget {
  const TranslationExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              spaceh(30),
              Row(
                children: [
                  ...supportedAppLocale.map(
                    (e) => TextButton(
                        onPressed: () {
                          context.setLocale(e.locale);
                          // logger(context.locale, 'current locale');
                        },
                        child: Text(e.name)),
                  )
                ],
              ),
              spaceh(30),
              const Text('Hello my name is belema'),
              // args
              const Text('msg').tr(args: ['Easy localization', 'Dart']),

// namedArgs
              const Text('msg_named').tr(namedArgs: {'lang': 'Dart'}),

// args and namedArgs
              const Text('msg_mixed')
                  .tr(args: ['Easy localization'], namedArgs: {'lang': 'Dart'}),

// gender
              // const Text('gender').tr(gender: _gender ? "female" : "male"),
            ],
          ),
        ),
      ),
    );
  }
}
