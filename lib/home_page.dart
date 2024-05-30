import 'package:any_test/core/globals.dart';
import 'package:any_test/core/navigations.dart';
import 'package:any_test/app/modules/test_lenght_module/text_lenght.dart';
import 'package:flutter/material.dart';

import 'app/modules/translation_test_module/translation_test.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            children: [
              spaceh(30),
              TextButton(
                  onPressed: () {
                    Nav.to(context, const TextLenght());
                  },
                  child: const Text('Text Lenght Test')),
              spaceh(20),
              TextButton(
                  onPressed: () {
                    Nav.to(context, const TranslationExample());
                  },
                  child: const Text('Translation Example')),
              spaceh(20)
            ],
          ),
        ),
      ),
    );
  }
}
