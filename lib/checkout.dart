import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Checkout extends StatelessWidget {
  //kasih listener untuk ganti screen setelah OTP diterima
  @override
  Widget build(BuildContext context) {
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
                "190202",
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