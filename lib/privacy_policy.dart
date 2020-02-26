import 'package:flutter/material.dart';

class PrivacyPolicy extends StatelessWidget {
  static const routeName = '/pP';
  //kasih listener untuk ganti screen setelah OTP diterima
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Privacy Policy")
      ),
      body: SingleChildScrollView(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
            SizedBox(height: 20),
            Text(
                "Privacy Policy",
                style: Theme.of(context).textTheme.title,
            ),
            SizedBox(height: 20),
            Divider(
                color: Colors.black,
            ),
            SizedBox(height: 50),
            Text("fskfhsjdhfkjshdjkfhkshdfhkhasjhfiaushfi",style: Theme.of(context).textTheme.body2,),
          ],
        ),
      ),
    );
  }
}