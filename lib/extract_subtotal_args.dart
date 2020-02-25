import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';

class ExtractSubtotalArgs extends StatelessWidget {
  static const routeName = '/extractArguments';

  @override
  Widget build(BuildContext context) {
    // Extract the arguments from the current ModalRoute settings and cast
    // them as ScreenArguments.
    final Args args = ModalRoute.of(context).settings.arguments;

    return Text(
      args.subtotal.toString(),
    );
  }
}