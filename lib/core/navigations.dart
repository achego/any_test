import 'package:flutter/material.dart';

class Nav {
  static to(BuildContext context, Widget page) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return page;
      },
    ));
  }
}
