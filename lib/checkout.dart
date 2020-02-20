import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';

class Checkout extends StatelessWidget {
  static const routeName = '/checkout';
  final int subtotal;
  // This Widget accepts the arguments as constructor parameters. It does not
  // extract the arguments from the ModalRoute.
  // The arguments are extracted by the onGenerateRoute function provided to the
  // MaterialApp widget.
  const Checkout({
    Key key,
    @required this.subtotal,
  }) : super(key: key);
  //kasih listener untuk ganti screen setelah OTP diterima
  @override
  Widget build(BuildContext context) {
    final Args args = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(
        title: Text("Checkout")
      ),
      body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
            Text(
                "Your Subtotal is:",
            ),
            SizedBox(height: 20),
            Text(
                args.subtotal.toString(),
            ),
            Divider(
                color: Colors.black,
            ),
            SizedBox(height: 50),
            Text("OTP HERE"),
          ],
        ),
      )
    );
  }
}