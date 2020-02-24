import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:webapp_super/args.dart';

class Checkout extends StatelessWidget {
  static const routeName = '/checkout'; 
  // This Widget accepts the arguments as constructor parameters. It does not
  // extract the arguments from the ModalRoute.
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